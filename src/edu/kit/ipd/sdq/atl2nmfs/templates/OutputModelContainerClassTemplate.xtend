package edu.kit.ipd.sdq.atl2nmfs.templates

import java.util.List
import edu.kit.ipd.sdq.atl2nmfs.helper.infos.ModelInfo

/**
 * The OutputModelContainerClassTemplate Class.
 */
class OutputModelContainerClassTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param namespace
	 *            the namespace
	 * @param outputModelInfos
	 *            the output model infos
	 * @param className
	 *            the class name
	 * @return the created code as string
	 */
	def static String createCode(String namespace, String className, List<ModelInfo> outputModelInfos) {
		var outputModelContainerTemplate = '''
			using NMF.Models;
			
			namespace «namespace»
			{
			    public class «className»
			    {
			        public «className»()
			        {
						«FOR outputModelInfo : outputModelInfos»
						«outputModelInfo.name» = new Model();
						«ENDFOR»
					}
					
			    	public «className»(«FOR outputModelInfo : outputModelInfos SEPARATOR ', '»Model «outputModelInfo.name»«ENDFOR») 
			    	{
						«FOR outputModelInfo : outputModelInfos»
						this.«outputModelInfo.name» = «outputModelInfo.name»;
						«ENDFOR»
					}
					
					«FOR outputModelInfo : outputModelInfos»
					public Model «outputModelInfo.name» { get; private set; }
					
					«ENDFOR»
				}
			}
		'''

		return outputModelContainerTemplate;
	}
}
