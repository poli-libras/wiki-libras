package br.usp.wikilibras.control;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.usp.libras.sign.Sign;

@Resource
@Path("/sign")
public class SignSymbolController {
	
    // manipula dados da requisição
    private Result result;

    // mantêm informações na sessão entre as requisições
    private SignEditionSession signEditionSession;

    // a cada requisição, os atributos são atualizados
    // exceto signEditor, que é componente de sessão
    public SignSymbolController(Result result, SignEditionSession signEditionSession) {
        this.result = result;
        this.signEditionSession = signEditionSession;
    }	

    /**
     * Prepara tela com ações para edição dos símbolos de um sinal
     */
    public Sign editSymbolsForm() {

        // fornece ao formulário os símbolos existentes no sinal
        result.include("symbols", this.signEditionSession.getSign().getSymbols());
        result.include("newSequence", this.signEditionSession.getSign().getSymbols().size());

        return this.signEditionSession.getSign();
    }

}
