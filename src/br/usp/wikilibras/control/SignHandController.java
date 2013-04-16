package br.usp.wikilibras.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.usp.libras.sign.Sign;
import br.usp.libras.sign.movement.HandMovement;
import br.usp.libras.sign.symbol.FingersMovement;
import br.usp.libras.sign.symbol.Hand;
import br.usp.libras.sign.symbol.HandShape;
import br.usp.libras.sign.symbol.HandSide;
import br.usp.libras.sign.symbol.ShapeGroup;

@Resource
@Path("/sign")
public class SignHandController {

    // manipula dados da requisição
    private Result result;

    // mantêm informações na sessão entre as requisições
    private SignEditionSession signEditionSession;

    // a cada requisição, os atributos são atualizados
    // exceto signEditor, que é componente de sessão
    public SignHandController(Result result, SignEditionSession signEditionSession) {
        this.result = result;
        this.signEditionSession = signEditionSession;
    }	

    /**
     * Prepara formulário de edição de mão
     * 
     * @param side diz se é mão dominante ou não-dominante que está sendo editada
     * @return
     */
    public Sign editHandForm(HandSide side) {

        // fornece para o formulário informação de configurações de mão disponíveis

        // lista com grupos de locações
        List<ShapeGroup> shapeGroups = new ArrayList<ShapeGroup>();
        // lista com todas as locações
        List<HandShape> shapes = new ArrayList<HandShape>();
        for (HandShape s : HandShape.values()) {
            shapes.add(s);
        }
        // mapa de listas de locações por grupo
        Map<ShapeGroup, List<HandShape>> shapeMap = new HashMap<ShapeGroup, List<HandShape>>();
        //shapeStringMap.put(ALL, shapes);
        for (ShapeGroup g : ShapeGroup.values()) {
            shapeGroups.add(g);
            for (HandShape s : HandShape.values()) {
                if (s.handGroup().equals(g)) {
                    if (shapeMap.get(g) == null)
                        shapeMap.put(g, new ArrayList<HandShape>());
                    shapeMap.get(g).add(s);
                }
            }
        }

        result.include("shapes", HandShape.values());
        result.include("shapeGroups", shapeGroups);
        result.include("shapesMap", shapeMap);
        result.include("fingers", FingersMovement.values());
        result.include("signIndex", this.signEditionSession.getSignIndex());
        result.include("handSide", side); // formulário precisa saber qual mão está sendo editada

        // caso estejamos editando o sinal
        if (!this.signEditionSession.isNewSign()) {

            // devemos passar ao fomrulário a mão a ser editada
            int idx = this.signEditionSession.getSignIndex();
            Hand hand = null;
            if (side == HandSide.RIGHT)
                hand = this.signEditionSession.getSign().getSymbols().get(idx - 1).getRightHand();
            if (side == HandSide.LEFT)
                hand = this.signEditionSession.getSign().getSymbols().get(idx - 1).getLeftHand();
            result.include("hand", hand);
        }

        this.signEditionSession.setSide(side);
        return this.signEditionSession.getSign();
    }

    /**
     * Processa formulário de edição de mão
     * 
     * @param hand mão atualizada
     * @return
     */
    public Sign editHand(Hand hand) {

        int signIndex = this.signEditionSession.getSignIndex();
        hand.setSide(this.signEditionSession.getSide());

        // ao atualizar a mão, devemos manter o mesmo movimento de antes!
        if (hand.getSide() == HandSide.RIGHT) {
            HandMovement mov = null;
            if (!this.signEditionSession.isNewSign()
                    && (this.signEditionSession.getSign().getSymbols().get(signIndex - 1).getRightHand() != null)) // se não é sinal novo e mão != null
                mov = this.signEditionSession.getSign().getSymbols().get(signIndex - 1).getRightHand().getMovement(); // backup
            this.signEditionSession.getSign().getSymbols().get(signIndex - 1).setRightHand(hand);
            this.signEditionSession.getSign().getSymbols().get(signIndex - 1).getRightHand().setMovement(mov);
        }
        if (hand.getSide() == HandSide.LEFT) {
            HandMovement mov = null;
            if ((!this.signEditionSession.isNewSign())
                    && (this.signEditionSession.getSign().getSymbols().get(signIndex - 1).getLeftHand() != null)) // se não é sinal novo e mão != null
                mov = this.signEditionSession.getSign().getSymbols().get(signIndex - 1).getLeftHand().getMovement(); // backup
            this.signEditionSession.getSign().getSymbols().get(signIndex - 1).setLeftHand(hand);
            this.signEditionSession.getSign().getSymbols().get(signIndex - 1).getLeftHand().setMovement(mov);
        }

        this.result.use(Results.logic()).redirectTo(SignMovementController.class).editHandMovementForm();

        return this.signEditionSession.getSign();
    }

}
