package br.usp.wikilibras.control;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.view.Results;
import br.usp.libras.sign.Sign;
import br.usp.libras.data.SignDaoFactory;

/**
 * Esse é o controller (mvC) que usa o framework VRaptor para criar o formulário de criação/edição de sinais Possue
 * métodos que preparam informações para as views (os JSPs) e métodos para processar a informação vinda dos formulários
 * 
 * @author leonardo
 * 
 */
@Resource
public class SignController {

    // gerencia os sinais no banco de dados
    private SignDaoFactory<Sign> daoFactory;

    // manipula dados da requisição
    private Result result;

    // faz a validação / consistência dos dados entrados pelo usuário
    private Validator validator;

    // mantêm informações na sessão entre as requisições
    private SignEditionSession signEditionSession;

    // a cada requisição, os atributos são atualizados
    // exceto signEditor, que é componente de sessão
    public SignController(SignDaoFactory<Sign> factory, Result result, SignEditionSession signEditionSession, Validator validator) {
        this.daoFactory = factory;
        this.result = result;
        this.signEditionSession = signEditionSession;
        this.validator = validator;
    }

    /**
     * Prepara formulário de inserção de novo sinal
     */
    public void newSignForm() {

    }

    /**
     * Processa formulário de inserção de novo sinal
     * 
     * @param sign objeto sinal com o nome do sinal a ser criado
     * @return o sinal criado na sessão
     */
    public Sign newSign(Sign sign) {

        // validação
        String name = sign.getName();
        if (name.isEmpty()) {
            validator.add(new ValidationMessage("Nome em branco não é permitido!", "erro"));
        }
        Sign outro = this.daoFactory.getSignDao().searchByName(name);
        if (outro != null) {
            validator.add(new ValidationMessage("Sinal " + name.toUpperCase() + " já está cadastrado!", "erro"));
        }
        validator.onErrorUsePageOf(SignController.class).newSignForm();

        // se validação ok...

        this.signEditionSession.setSign(new Sign());
        this.signEditionSession.getSign().setName(sign.getName().toUpperCase()); // nomes dos sinais é sempre tudo maiúsculo
        this.signEditionSession.getSign().setInserted(new Date());
        this.signEditionSession.setNewSign(true);
        this.result.use(Results.logic()).redirectTo(SignSyntaxController.class).editSyntaxForm();

        return this.signEditionSession.getSign();
    }

    /**
     * Prepara formulário de edição de sinal
     */
    public void editSignForm() {

    }

    /**
     * Processa formulário que define sinal a ser editado Pose também ser acessado diretamente pela URL (requisição GET)
     * ex de URI: WikiLibras/editSign?name=NOME_DO_SINAL
     * 
     * @param signName nome do sinal a ser editado, será procurado na base de dados
     * @return o sinal encontrado no banco de dados, que será editado
     */
    @Get
    @Post
    @Path("/editSign")
    public Sign editSign(String signName) {

        // validação
        if (signName.isEmpty()) {
            validator.add(new ValidationMessage("Nome em branco não é permitido!", "erro"));
        } else {
            Sign outro = this.daoFactory.getSignDao().searchByName(signName);
            if (outro == null) {
                validator.add(new ValidationMessage("Sinal " + signName.toUpperCase() + " não existe!", "erro"));
            }
        }
        validator.onErrorUsePageOf(SignController.class).editSignForm();

        // se validação ok...

        // busca sinal a ser editado no banco de dados
        Sign sign = this.daoFactory.getDao().search(signName.toUpperCase());

        if (sign != null) {
            // sinal encontrado
            this.signEditionSession.setSign(sign);
            this.signEditionSession.setNewSign(false);
            this.result.use(Results.logic()).redirectTo(SignSyntaxController.class).editSyntaxForm();
            return this.signEditionSession.getSign();
        } else {
            // nome de sinal inválido
            // TODO: usar um validator
            this.result.use(Results.logic()).redirectTo(SignController.class).editSignForm();
            return null;
        }
    }







    /**
     * Salva/atualiza a edição do sinal feita na sessão
     */
    public void finish() {

        if (this.signEditionSession.isNewSign()) { // criação de sinal

            this.daoFactory.getDao().save(this.signEditionSession.getSign()); // salva sinal no banco de dados 
            this.result.use(Results.logic()).redirectTo(SignController.class).show(); // mostra sinal recêm editado
        } else { // edição de sinal

            this.daoFactory.getDao().merge(this.signEditionSession.getSign()); // atualiza sinal no banco de dados
            this.result.use(Results.logic()).redirectTo(SignSymbolController.class).editSymbolsForm(); // volta pra edição de símbolos
        }
        // TODO: o merge troca o id do símbolo, trocando a ordem dos símbolo!!! =O

    }

    /**
     * Exibe o sinal sendo editado/criado na sessão
     * 
     * @return
     */
    public Sign show() {

        Sign sign = this.signEditionSession.getSign();
        this.signEditionSession = null; // evita problemas com a sessão
        // TODO: limpar a sessão adequadamente

        // código repetido! =O
        try {
            String editLink = "/wikilibras/editSign?signName=" + URLEncoder.encode(sign.getName(), "ISO-8859-1");
            String deleteLink = "/wikilibras/deleteSign?signName=" + URLEncoder.encode(sign.getName(), "ISO-8859-1");
            this.result.include("editLink", editLink);
            this.result.include("deleteLink", deleteLink);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return sign;
    }

    /**
     * Exibe sinal para usuário ex de URI: WikiLibras/sign?name=NOME_DO_SINAL
     * 
     * @param name nome do sinal
     * @return
     */
    @Get
    @Path("/sign")
    public Sign show(String name) {

        // busca sinal no banco de dados
        Sign sign = this.daoFactory.getDao().search(name);
        if (sign != null) {
            try {
                String editLink = "/wikilibras/editSign?signName=" + URLEncoder.encode(name, "ISO-8859-1");
                String deleteLink = "/wikilibras/deleteSign?signName=" + URLEncoder.encode(name, "ISO-8859-1");
                this.result.include("editLink", editLink);
                this.result.include("deleteLink", deleteLink);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }

        }
        return sign;
    }    

    /**
     * Exclui sinal, ex de URI: wikilibras/deleteSign?name=NOME_DO_SINAL
     * 
     * @param name nome do sinal
     * @return
     */
    @Get
    @Path("/deleteSign")
    public String deleteSign(String signName) {

        // busca sinal no banco de dados
        Sign sign = this.daoFactory.getDao().search(signName);
        if (sign != null) {
        	
        	this.daoFactory.getDao().delete(sign);
            return "Sinal " + signName + " excluído";
        } else {
        	
        	return "Sinal " + signName + " não existe.";
        }
    }    
}
