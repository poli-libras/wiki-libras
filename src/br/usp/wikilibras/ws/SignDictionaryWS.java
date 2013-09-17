package br.usp.wikilibras.ws;

import java.util.ArrayList;
import java.util.List;

import javax.jws.WebService;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;

import br.usp.libras.sign.Sign;
import br.usp.libras.data.SignDao;
import br.usp.libras.data.SignDaoFactory;

@WebService(endpointInterface="br.usp.wikilibras.ws.ISignDictionaryWS")
public class SignDictionaryWS implements ISignDictionaryWS {
    
    private SignDao dao;
    
    public SignDictionaryWS() {
        
        // obtendo o dao que acessa o banco de dados pelo Hibernate
        SessionFactory sessions = new AnnotationConfiguration().configure().buildSessionFactory();
        Session session = sessions.openSession();        
        SignDaoFactory<Sign> factory = new SignDaoFactory<Sign>(session);
        this.dao = factory.getSignDao();
    }

    @Override
    public Sign signByName(String name) {
        
        return dao.searchByName(name);
    }

    @Override
    public List<Sign> nearSigns(String name) {

        List<Sign> signs = dao.searchByNearName(name);
        if (signs != null)
            return signs;
        else
            return new ArrayList<Sign>();
    }

    @Override
    public List<Sign> translate(String word) {
        
        List<Sign> signs = dao.searchByWord(word);
        if (signs != null)
            return signs;
        else
            return new ArrayList<Sign>();
    }

    @Override
    public Sign simpleTranslate(String word) {

        List<Sign> signs = dao.searchByWord(word);
        if (signs.isEmpty())
            return null;
        else
            return signs.get(0);
    }
    
}
