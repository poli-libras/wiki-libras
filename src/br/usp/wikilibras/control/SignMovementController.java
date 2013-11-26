package br.usp.wikilibras.control;

import java.util.ArrayList;
import java.util.List;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.usp.libras.sign.Sign;
import br.usp.libras.sign.movement.Direction;
import br.usp.libras.sign.movement.HandMovement;
import br.usp.libras.sign.movement.Magnitude;
import br.usp.libras.sign.movement.MovementType;
import br.usp.libras.sign.movement.Segment;
import br.usp.libras.sign.symbol.Hand;
import br.usp.libras.sign.symbol.HandSide;

@Resource
@Path("/sign")
public class SignMovementController {

    // manipula dados da requisição
    private Result result;

    // mantêm informações na sessão entre as requisições
    private SignEditionSession signEditionSession;

    // a cada requisição, os atributos são atualizados
    // exceto signEditor, que é componente de sessão
    public SignMovementController(Result result, SignEditionSession signEditionSession) {
        this.result = result;
        this.signEditionSession = signEditionSession;
    }	

    /**
     * Prepara formulário de edição de movimento de mão
     * 
     * @return
     */
    public Sign editHandMovementForm() {

        // fornece ao fomrulário informação sobre os possíveis valores dos atributos de movimento
        result.include("types", MovementType.values());
        result.include("directions", Direction.values());
            // magnitudes: feito desse jeito pra alterar a ordem do array, 
            // para que a opção default fique em primeiro
        result.include("magnitudes", new Magnitude[]{Magnitude.NORMAL, Magnitude.CURTO, Magnitude.LONGO}); 
        result.include("signIndex", this.signEditionSession.getSymbolIndex());
        result.include("handSide", this.signEditionSession.getSide());
        result.include("noMove", false); // padrão, em caso de criação de sinal

        // caso estejamos editando o sinal
        if (!this.signEditionSession.isNewSign()) {

            // devemos informar ao formulário o movimento a ser editado
            HandSide side = this.signEditionSession.getSide();
            int idx = this.signEditionSession.getSymbolIndex();
            Hand hand = null;
            if (side == HandSide.RIGHT)
                hand = this.signEditionSession.getSign().getSymbols().get(idx - 1).getRightHand();
            if (side == HandSide.LEFT)
                hand = this.signEditionSession.getSign().getSymbols().get(idx - 1).getLeftHand();
            result.include("noMove", hand.getMovement() == null);

            if (hand.getMovement() != null) {
                result.include("handMovement", hand.getMovement());
                // devemos também informar os segmentos do movimento
                List<Segment> segments = new ArrayList<Segment>();
                for (Segment seg : hand.getMovement().getSegments()) {
                    segments.add(seg);
                }
                result.include("segments", segments);
            }
        }
        return this.signEditionSession.getSign();
    }

    /**
     * Processa formulário de edição de movimento de mão
     * 
     * @param noMove diz se movimento deve ser desconsiderado
     * @param handMovement movimento atualizado
     */
    public void editHandMovement(boolean noMove, HandMovement handMovement, String[] direction, String[] magnitude) {

        int signIndex = this.signEditionSession.getSymbolIndex();
        HandSide side = this.signEditionSession.getSide();

        Hand hand = null;
        if (side == HandSide.RIGHT)
            hand = this.signEditionSession.getSign().getSymbols().get(signIndex - 1).getRightHand();
        if (side == HandSide.LEFT)
            hand = this.signEditionSession.getSign().getSymbols().get(signIndex - 1).getLeftHand();

        // atualizado o movimento
        if (noMove)
            hand.setMovement(null);
        else {
            hand.setMovement(handMovement);
            if (direction != null) {
                boolean first = true;
                List<Segment> segs = new ArrayList<Segment>();
                for (int i=0; i<direction.length; i++) {
                    if (first) {
                        first = false; // gambiarra: se tivesse só um, VRaptor não criaria array... 
                        // então tem sempre um fantasminha pra garantir o array
                    } else {
                        Direction d = Enum.valueOf(Direction.class, direction[i]);
                        Magnitude m = Enum.valueOf(Magnitude.class, magnitude[i]);
                        Segment s = new Segment();
                        s.setDirection(d);
                        s.setMagnitude(m);
                        segs.add(s);
                    }
                }
                handMovement.setSegments(segs);
            }
        }

        // decide se edita a mão não-dominante ou se passa para a expressão facial
        if (side == HandSide.RIGHT) {
            if (this.signEditionSession.isTwoHands()) {
                this.result.use(Results.logic()).redirectTo(SignLocationController.class).editLocationForm(HandSide.LEFT);
            } else {
                this.result.use(Results.logic()).redirectTo(SignFaceController.class).editFaceForm();
            }
        }
        if (side == HandSide.LEFT)
            this.result.use(Results.logic()).redirectTo(SignFaceController.class).editFaceForm();
    }

}
