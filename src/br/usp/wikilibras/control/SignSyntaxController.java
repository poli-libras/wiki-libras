package br.usp.wikilibras.control;

import java.util.Date;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.usp.libras.sign.Sign;
import br.usp.libras.sign.VerbType;
import br.usp.libras.sign.symbol.HandSide;
import br.usp.wikilibras.data.SignDaoFactory;

@Resource
@Path("/sign")
public class SignSyntaxController {

    // gerencia os sinais no banco de dados
    private SignDaoFactory<Sign> daoFactory;

    // manipula dados da requisição
    private Result result;

    // mantêm informações na sessão entre as requisições
    private SignEditionSession signEditionSession;

    // a cada requisição, os atributos são atualizados
    // exceto signEditor, que é componente de sessão
    public SignSyntaxController(SignDaoFactory<Sign> factory, Result result, SignEditionSession signEditionSession) {
        this.daoFactory = factory;
        this.result = result;
        this.signEditionSession = signEditionSession;
    }

    /**
     * Prepara formulário de edição da sintaxe do sinal
     */
    public Sign editSyntaxForm() {

        // fornece para o formulário os valores atuais da sintaxe do sinal (words, literals e inherences)
        result.include("words", this.signEditionSession.getSign().getWords());
        result.include("verbs", VerbType.values());
        result.include("literals", this.signEditionSession.getSign().getLiterals());
        result.include("inherences", this.signEditionSession.getSign().getInherences());

        return this.signEditionSession.getSign();
    }

    /**
     * Processa formulário de edição da sintaxe do sinal
     * 
     * @param sign
     * @param word
     * @param literal
     * @param inherence
     */
    public void editSyntax(Sign sign, String[] word, String[] literal, String[] inherence) {

        // limpa dados para não haver duplicação (dados atuais tb devem chegar pelo formulário!)
        this.signEditionSession.getSign().getWords().clear();
        this.signEditionSession.getSign().getLiterals().clear();
        this.signEditionSession.getSign().getInherences().clear();

        // atualiza data de edição do sinal
        Date now = new Date(System.currentTimeMillis());
        this.signEditionSession.getSign().setInserted(now);

        // TODO: deve haver pelo menos um word

        // incorpora wods, literals e inherences ao sinal
        if (word != null) {
            for (String s : word)
                if (!s.isEmpty())
                    this.signEditionSession.getSign().addWord(s);
        }

        this.signEditionSession.getSign().setVerbType(sign.getVerbType());

        if (literal != null) {
            for (String s : literal)
                if (!s.isEmpty())
                    this.signEditionSession.getSign().addLiteral(s);
        }
        if (inherence != null) {
            for (String s : inherence)
                if (!s.isEmpty())
                    this.signEditionSession.getSign().addInherence(s);
        }

        // por padrão, o primeiro símbolo a ser criado/editado é o primeiro do sinal (sequẽncia temporal)
        this.signEditionSession.setSymbolIndex(1);
        if (this.signEditionSession.isNewSign()) {
            this.result.use(Results.logic()).redirectTo(SignLocationController.class).editLocationForm(HandSide.RIGHT); // edita símbolo 1 em caso de inserção
        } else {
            this.daoFactory.getDao().merge(this.signEditionSession.getSign());
            this.result.use(Results.logic()).redirectTo(SignSymbolController.class).editSymbolsForm(); // usuário escolhe qual símbolo editar (caso edição)
        }
    }

}
