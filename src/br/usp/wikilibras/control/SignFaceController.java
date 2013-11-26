package br.usp.wikilibras.control;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.usp.libras.sign.Sign;
import br.usp.libras.sign.face.Chin;
import br.usp.libras.sign.face.Eyebrow;
import br.usp.libras.sign.face.Eyes;
import br.usp.libras.sign.face.Face;
import br.usp.libras.sign.face.Forehead;
import br.usp.libras.sign.face.Gaze;
import br.usp.libras.sign.face.Mounth;
import br.usp.libras.sign.face.Nose;
import br.usp.libras.sign.face.Others;
import br.usp.libras.sign.face.Teeth;
import br.usp.libras.sign.face.Tongue;
import br.usp.libras.sign.symbol.HandSide;

@Resource
@Path("/sign")
public class SignFaceController {

    // manipula dados da requisição
    private Result result;

    // mantêm informações na sessão entre as requisições
    private SignEditionSession signEditionSession;

    // a cada requisição, os atributos são atualizados
    // exceto signEditor, que é componente de sessão
    public SignFaceController(Result result, SignEditionSession signEditionSession) {
        this.result = result;
        this.signEditionSession = signEditionSession;
    }	
	
    /**
     * Prepara formulário de edição de expressão facial
     * 
     * @return
     */
    public Sign editFaceForm() {

        int idx = this.signEditionSession.getSymbolIndex();

        // fornece os subsídios ao formulário
        result.include("chins", Chin.values());
        result.include("eyebrows", Eyebrow.values());
        result.include("eyes", Eyes.values());
        result.include("foreheads", Forehead.values());
        result.include("gazes", Gaze.values());
        result.include("mounths", Mounth.values());
        result.include("noses", Nose.values());
        result.include("others", Others.values());
        result.include("teeth", Teeth.values());
        result.include("tongues", Tongue.values());
        result.include("signIndex", idx);
        result.include("noFace", false);
        result.include("newSign", this.signEditionSession.isNewSign());

        // se estamos editando o sinal
        if (!this.signEditionSession.isNewSign()) {

            // informamos ao fomrulário a expressão facial a ser editada
            Face face = this.signEditionSession.getSign().getSymbols().get(idx - 1).getFace();
            result.include("face", face);
            result.include("noFace", face == null);
        }

        // TODO: diferenciar botões de finalização para "criação" e "edição" 
        return this.signEditionSession.getSign();
    }

    /**
     * Processa formulário de expressão facial
     * 
     * @param noFace diz se expressão facial deve ser desconsiderada
     * @param face expressão facial atualizada
     * @param moreSymbols diz se formulário vota para inserção de mais um símbolo
     */
    public void editFace(boolean noFace, Face face, boolean moreSymbols) {

        // se todos os atributos da face forem NADA, salva como null
        if ((face != null) && (face.allIsNada()))
            face = null;

        int signIndex = this.signEditionSession.getSymbolIndex();

        // atualiza a expressão facial
        if (!noFace) {
            this.signEditionSession.getSign().getSymbols().get(signIndex - 1).setFace(face);
        } else {
            this.signEditionSession.getSign().getSymbols().get(signIndex - 1).setFace(null);
        }

        // decide se se acrescenta mais símbolos ou se finaliza edição
        if (moreSymbols) {
            this.signEditionSession.incrementSignIndex();
            this.result.use(Results.logic()).redirectTo(SignLocationController.class).editLocationForm(HandSide.RIGHT);
        } else {
            // finaliza edição!
            this.result.use(Results.logic()).redirectTo(SignController.class).finish();
        }
    }

}
