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
import br.usp.libras.sign.symbol.ContactType;
import br.usp.libras.sign.symbol.Hand;
import br.usp.libras.sign.symbol.HandSide;
import br.usp.libras.sign.symbol.Location;
import br.usp.libras.sign.symbol.LocationGroup;
import br.usp.libras.sign.symbol.Symbol;

@Resource
@Path("/sign")
public class SignContactController {
	
    private static final String ALL = "TODOS OS GRUPOS";

    // manipula dados da requisição
    private Result result;

    // mantêm informações na sessão entre as requisições
    private SignEditionSession signEditionSession;

    // a cada requisição, os atributos são atualizados
    // exceto signEditor, que é componente de sessão
    public SignContactController(Result result, SignEditionSession signEditionSession) {
        this.result = result;
        this.signEditionSession = signEditionSession;
    }	

    /**
     * Prepara formulário de edição de símbolo
     * 
     * @return
     */
    public Sign editContactForm() {
    	
        int symbolIndex = this.signEditionSession.getSymbolIndex();
        HandSide side = this.signEditionSession.getSide();
        
        result.include("locations", Location.values());
        result.include("handSide", side);
        result.include("symbolIndex", symbolIndex);
        result.include("newSign", this.signEditionSession.isNewSign());

        if (!this.signEditionSession.isNewSymbol()) {

            // devemos passar para o formulário o contato atual
            Hand hand= this.signEditionSession.getSign().getSymbols().get(symbolIndex - 1).getHand(this.signEditionSession.getSide());
            result.include("contact", hand.getContact());
        }

        return this.signEditionSession.getSign();
    }
    
    /**
     * Processa formulário de edição de contato
     * 
     * @param contact
     * @return
     */
    public Sign editContact(Contact contact) {
    	Sign sign = this.signEditionSession.getSign();
    	int symbolIndex = this.signEditionSession.getSymbolIndex();
    	HandSide side = this.signEditionSession.getSide();
    	Hand hand = sign.getSymbols().get(symbolIndex - 1).getHand(side);
    	hand.setContact(contact);
    	
        this.result.use(Results.logic()).redirectTo(SignHandController.class).editHandForm();

        return this.signEditionSession.getSign();
    }

}
