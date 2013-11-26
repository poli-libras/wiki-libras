package br.usp.wikilibras.control;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.SessionScoped;
import br.usp.libras.sign.Sign;
import br.usp.libras.sign.symbol.HandSide;

/**
 * Este é um componente VRaptor de sessão para auxiliar 
 * o SignController a manter informações entre as requisições,
 * já que o formulário é dividido em vários passos (i.e.: várias requisições)
 *  
 * @author leonardo
 *
 */
@Component
@SessionScoped
class SignEditionSession {
    
    // sinal que está sendo criado/editado
    private Sign sign;
    // índice do símbolo sendo editado como é mostrado para o usuário 
    // na lista é acessado como signIndex-1
    private int symbolIndex = 1; 
    private HandSide side;
    private boolean twoHands = true;
    //indica se estamos editando um novo sinal
    private boolean newSign; 

    public Sign getSign() {
        return sign;
    }
    public void setSign(Sign sign) {
        this.sign = sign;
    }
    public int getSymbolIndex() {
        return symbolIndex;
    }
    public void setSymbolIndex(int symbolIndex) {
        this.symbolIndex = symbolIndex;
    }
    public HandSide getSide() {
        return side;
    }
    public void setSide(HandSide side) {
        this.side = side;
    }
    public boolean isTwoHands() {
        return twoHands;
    }
    public void setTwoHands(boolean twoHands) {
        this.twoHands = twoHands;
    }
    public void incrementSignIndex() {
        this.symbolIndex = this.symbolIndex + 1;
    }
    public boolean isNewSign() {
        return newSign;
    }
    public void setNewSign(boolean newSign) {
        this.newSign = newSign;
    }
    public boolean isNewSymbol() {
		return this.getSign().getSymbols().size() < this.getSymbolIndex();
	}
}
