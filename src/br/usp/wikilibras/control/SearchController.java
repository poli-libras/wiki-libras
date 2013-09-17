package br.usp.wikilibras.control;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.usp.libras.sign.Sign;
import br.usp.libras.data.SignDao;
import br.usp.libras.data.SignDaoFactory;

@Resource
public class SearchController {
    
    // gerencia os sinais no banco de dados
    private SignDao signDao;
    
    // manipula dados da requisição
    private Result result;
    
    public SearchController(SignDaoFactory<Sign> daoFactory, Result result) {
        
        this.signDao = daoFactory.getSignDao();
        this.result = result;
    }

    /**
     * Prepara formulário de busca
     */
    public void searchForm() {
        
    }

    /**
     * Processa formulário de busca
     * Realizar a busca procurando pelo parâmetro sendo
     * aproximadamente o nome do sinal
     * ou aproximadamente uma word do sinal
     * (aproximadamente = LIKE %param% no SQL)
     * 
     * @param word parâmetro de busca
     * @return
     */
    public void search(String word) {
        
        List<Sign> signs1 = this.signDao.searchByNearName(word);
        List<Sign> signs2 = this.signDao.searchByNearWord(word);

        for (Sign s: signs2) {
            if (!signs1.contains(s)) {
                signs1.add(s);
            }
        }
        
        List<String> signNames = new ArrayList<String>();
        for (Sign s: signs1) {
            signNames.add(s.getName());
        }

        this.result.use(Results.logic()).redirectTo(SearchController.class).searchResultForm(signNames);
    }
    
    /**
     * Lista todos os sinais na base de dados
     * @return
     */
    public void searchAll() {

        List<Sign> signs = this.signDao.listAll();
        List<String> signNames = new ArrayList<String>();
        for (Sign s: signs) {
            signNames.add(s.getName());
        }
        this.result.use(Results.logic()).redirectTo(SearchController.class).searchResultForm(signNames);
    }

    /**
     * Prepara o form que mostra os resultados da busca
     * @param signs
     */
    public void searchResultForm(List<String> signNames) {
        
        // ordena em ordem alfabética
        Collections.sort(signNames);
        
        // mapa de links
        Map<String, String> links = new HashMap<String, String>();
        for (String name: signNames) {
            String url = null;
            try {
                // não entendi o porquê de usar este encoding, mas é assim que funfa!!!
                url = "/wikilibras/sign?name=" + URLEncoder.encode(name, "ISO-8859-1"); 
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            links.put(name, url);
        }
        
        
        result.include("signs", signNames);
        result.include("links", links);
        if (signNames == null || signNames.size() == 0)
            result.include("found", false);
        else
            result.include("found", true);
    }
    
    public void searchResult(int signId) {
        
    }
}
