package br.usp.wikilibras.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.usp.libras.sign.Sign;
import br.usp.libras.sign.symbol.Contact;
import br.usp.libras.sign.symbol.HandSide;
import br.usp.libras.sign.symbol.Location;
import br.usp.libras.sign.symbol.LocationGroup;
import br.usp.libras.sign.symbol.Symbol;

@Resource
@Path("/sign")
public class SignSymbolController {
	
    private static final String ALL = "TODOS OS GRUPOS";

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
     * Prepara formulário de edição de símbolo
     * 
     * @return
     */
    public Sign editSymbolForm() {

        // símbolo a ser editado já está determinado na sessão (signEditor)
        int signIndex = this.signEditionSession.getSignIndex();

        // fornece informações sobre locações e contatos disponíveis para o formulário

        // lista com grupos de locações
        List<String> locationGroups = new ArrayList<String>();
        locationGroups.add(ALL);
        // lista com todas as locações
        List<String> locations = new ArrayList<String>();
        for (Location s : Location.values()) {
            locations.add(s.toString());
        }
        // mapa de listas de locações por grupo
        Map<String, List<String>> locMap = new HashMap<String, List<String>>();
        locMap.put(ALL, locations);
        for (LocationGroup g : LocationGroup.values()) {
            locationGroups.add(g.toString());
            for (Location s : Location.values()) {
                if (s.locationGroup() == g) {
                    if (locMap.get(g.toString()) == null)
                        locMap.put(g.toString(), new ArrayList<String>());
                    locMap.get(g.toString()).add(s.toString());
                }
            }
        }

        result.include("contacts", Contact.values());
        result.include("locations", Location.values());
        result.include("locationGroups", locationGroups);
        result.include("locationsMap", locMap);
        result.include("signIndex", signIndex);
        result.include("newSign", this.signEditionSession.isNewSign());
        result.include("twoHands", true); // padrão para caso de inclusão de sinal

        // caso estejamos editando o símbolo
        if (!this.signEditionSession.isNewSign() && (this.signEditionSession.getSign().getSymbols().size() >= signIndex)) {

            // devemos passar para o fomrulário o símbolo a ser editado
            Symbol symbol = this.signEditionSession.getSign().getSymbols().get(signIndex - 1);
            this.signEditionSession.setTwoHands(symbol.getLeftHand() != null);
            result.include("symbol", symbol);
            result.include("twoHands", this.signEditionSession.isTwoHands());
        }

        return this.signEditionSession.getSign();
    }

    /**
     * Processa formulário de edição de símbolo
     * 
     * @param symbol símbolo atualizado
     * @param twoHands diz se sinal terá duas mãos ou apenas a mão dominante
     * @return
     */
    public Sign editSymbol(Symbol symbol, boolean twoHands) {

    	// forçando invariantes
    	if (symbol.getContact() == null || symbol.getContact() == Contact.NENHUM)
    		symbol.setContactQuantity(0);
        if (!twoHands) {
            symbol.setLeftHand(null);
            symbol.setHandsInUnity(false);
        }
        this.signEditionSession.setTwoHands(twoHands);
        
        int index = this.signEditionSession.getSignIndex();
        if (this.signEditionSession.isNewSign() || (this.signEditionSession.getSign().getSymbols().size() < index)) { // criação de símbolo
            symbol.setSequence(index - 1);
            this.signEditionSession.getSign().addSymbol(symbol);
        } else { // edição de símbolo
            // informações gerais do símbolo são atualizadas
            Symbol sy = this.signEditionSession.getSign().getSymbols().get(index - 1);
            sy.setSequence(index - 1);
            sy.setLocation(symbol.getLocation());
            sy.setContact(symbol.getContact());
            sy.setContactQuantity(symbol.getContactQuantity());
            sy.setHandsInUnity(symbol.isHandsInUnity());
        }

        // primeiro editar a mão-dominante
        this.result.use(Results.logic()).redirectTo(SignHandController.class).editHandForm(HandSide.RIGHT);

        return this.signEditionSession.getSign();
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

    /**
     * Atualiza o símbolo a ser editado na sessão
     * 
     * @param index índice do símbolo (a ser editado) na lista de símbolos do sinal
     */
    @Get
    @Path("/symbol")
    public void editSymbolForm(int index) {

        this.signEditionSession.setSignIndex(index);
        this.result.use(Results.logic()).redirectTo(SignSymbolController.class).editSymbolForm();
    }

}
