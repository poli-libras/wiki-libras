package br.usp.wikilibras.control;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.usp.libras.sign.Sign;
import br.usp.libras.sign.symbol.Hand;
import br.usp.libras.sign.symbol.HandSide;
import br.usp.libras.sign.symbol.Location;

@Resource
@Path("/sign")
public class SignLocationController {
	
    // manipula dados da requisição
    private Result result;

    // mantêm informações na sessão entre as requisições
    private SignEditionSession signEditionSession;

    // a cada requisição, os atributos são atualizados
    // exceto signEditor, que é componente de sessão
    public SignLocationController(Result result, SignEditionSession signEditionSession) {
        this.result = result;
        this.signEditionSession = signEditionSession;
    }	

    /**
     * Prepara formulário de edição de símbolo
     * 
     * @return
     */
    public Sign editLocationForm(HandSide side) {
    	this.signEditionSession.setSide(side);
    	
        int symbolIndex = this.signEditionSession.getSymbolIndex();
        
        result.include("locations", Location.values());
        result.include("handSide", side);
        result.include("symbolIndex", symbolIndex);
        result.include("newSign", this.signEditionSession.isNewSign());

        if (!this.signEditionSession.isNewSymbol()) {

            // devemos passar para o formulário a locação atual
            Hand hand= this.signEditionSession.getSign().getSymbols().get(symbolIndex - 1).getHand(this.signEditionSession.getSide());
            result.include("location", hand.getLocation());
        }
        
        System.out.println ("AAAAAAAAAAAAAAAAAAAAAAA");
        
        return this.signEditionSession.getSign();
    }
    
    /**
     * Processa formulário de edição de locação
     * 
     * @param location
     * @return
     */
    public Sign editLocation(Location location) {
    	Sign sign = this.signEditionSession.getSign();
    	int symbolIndex = this.signEditionSession.getSymbolIndex();
    	HandSide side = this.signEditionSession.getSide();
    	Hand hand = sign.getSymbols().get(symbolIndex - 1).getHand(side);
    	hand.setLocation(location);
    	
        this.result.use(Results.logic()).redirectTo(SignContactController.class).editContactForm();

        return this.signEditionSession.getSign();
    }

    /**
     * Atualiza o símbolo a ser editado na sessão
     * 
     * @param index índice do símbolo (a ser editado) na lista de símbolos do sinal
     */
    @Get
    @Path("/location")
    public void editLocationForm(int symbol_index) {

        this.signEditionSession.setSymbolIndex(symbol_index);
        this.result.use(Results.logic()).redirectTo(SignLocationController.class).editLocationForm(HandSide.RIGHT);
    }

}
