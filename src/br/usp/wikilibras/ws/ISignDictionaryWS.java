package br.usp.wikilibras.ws;

import java.util.List;

import javax.jws.WebMethod;
import javax.jws.WebService;

import br.usp.libras.sign.Sign;

@WebService
public interface ISignDictionaryWS {
    
    /**
     * Obtêm um sinal pelo seu nome
     * @param name nome exato do sinal (ex: SENTAR-EM-RODA)
     * @return o sinal correspondente ou null em caso de não haver sinal
     */
    @WebMethod
    public Sign signByName(String name);

    /**
     * Obtêm os sinais cujos nomes se assemelham ao argumento
     * @param name o nome aproximado do sinal (ex: SENTAR)
     * @return os sinais correspondentes (ex: SENTAR, SENTAR-EM-RODA, SENTAR-NA-CADEIRA)
     */
    @WebMethod    
    public List<Sign> nearSigns(String name);
    
    /**
     * Traduz uma palavra em português para LIBRAS
     * @param word palavra em português
     * @return lista dos sinais que possivelmente correspondem à palavra dada
     */
    @WebMethod
    public List<Sign> translate(String word);
    
    /**
     * Traduz uma palavra em português para LIBRAS
     * Caso haja vários possíveis sinais correspondentes,
     * a implementação decidirá qual sinal será retornado
     * @param word palavra em português
     * @return um sinal em LIBRAS que corresponde à palavra dada
     */
    @WebMethod
    public Sign simpleTranslate(String word);

}
