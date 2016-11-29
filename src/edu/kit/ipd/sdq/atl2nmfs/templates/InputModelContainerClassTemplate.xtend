package edu.kit.ipd.sdq.atl2nmfs.templates

import java.util.List
import edu.kit.ipd.sdq.atl2nmfs.helper.infos.ModelInfo

/**
 * The InputModelContainerClassTemplate Class.
 */
class InputModelContainerClassTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param namespace
	 *            the namespace
	 * @param inputModelInfos
	 *            the input model infos
	 * @param className
	 *            the class name
	 * @return the created code as string
	 */
	def static String createCode(String namespace, String className,
		List<ModelInfo> inputModelInfos) {
		var inputModelContainerTemplate = '''
			using NMF.Models;
			
			namespace «namespace»
			{
			    public class «className»
			    {
			    	public «className»(«FOR inputModelInfo : inputModelInfos SEPARATOR ', '»Model «inputModelInfo.name»«ENDFOR») 
			    	{
						«FOR inputModelInfo : inputModelInfos»
						this.«inputModelInfo.name» = «inputModelInfo.name»;
						«ENDFOR»
					}
					
					«FOR inputModelInfo : inputModelInfos»
					public Model «inputModelInfo.name» { get; private set; }
					
					«ENDFOR»
				}
			}
		'''

		return inputModelContainerTemplate;
	}
}
