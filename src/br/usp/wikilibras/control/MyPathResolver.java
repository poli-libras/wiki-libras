package br.usp.wikilibras.control;

import java.util.Arrays;
import java.util.List;

import br.com.caelum.vraptor.http.FormatResolver;
import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.resource.ResourceMethod;
import br.com.caelum.vraptor.view.DefaultPathResolver;

/**
 * Altera o comportamento padrão do VRaptor para redirecionamento das viwes
 * 
 * Como eu quebrei o SignController em vários controllers,
 * já que ele estava muito grande,
 * esta classe existe para manter os jsps do formulário
 * de edição de sinal na mesma pasta,
 * se não haveria um jsp por pasta e muitas pastas
 * 
 * Código baseado em 
 * https://github.com/caelum/vraptor/blob/master/vraptor-core/src/main/java/br/com/caelum/vraptor/view/DefaultPathResolver.java
 * 
 * @author leonardo
 *
 */
@Component
public class MyPathResolver extends DefaultPathResolver{

	public static String SIGN_CONTROLLER_FOLDER = "sign";
	public static String[] CONTROLLERS = new String[]{"SignSyntaxController", "SignSymbolController",
		"SignHandController", "SignMovementController", "SignFaceController", "SignLocationController", 
		"SignContactController"};
	
	private FormatResolver resolver;
	
	public MyPathResolver(FormatResolver resolver) {
		super(resolver);
		this.resolver = resolver;
	}
	
	private String getSuffix() {
		String format = resolver.getAcceptFormat();
		String suffix = "";
		if (format != null && !format.equals("html")) {
			suffix = "." + format;
		}
		return suffix;
	}

	@Override
	public String pathFor(ResourceMethod method){
	
		List<String> controllers = Arrays.asList(CONTROLLERS);
		String name = method.getResource().getType().getSimpleName();
		
		if (!controllers.contains(name))
			return super.pathFor(method);
		else {
			String path = getPrefix() + SIGN_CONTROLLER_FOLDER + "/" + method.getMethod().getName() 
					+ getSuffix() + "."+getExtension();
			return path;
		}
	}
	
}
