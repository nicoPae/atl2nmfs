package edu.kit.ipd.sdq.atl2nmfs.templates

import edu.kit.ipd.sdq.atl2nmfs.helper.infos.HelperInfo

/**
 * The AttributeHelperTemplate Class.
 */
class AttributeHelperTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param helperInfo
	 *            the helper info
	 * @return the created code as string
	 */
	def static String createCode(HelperInfo helperInfo) {
		// ATL attribute helper can't have parameters
		// it is important that the parameter has the name self because this name is used in the expression
		var attributeHelperTemplate = '''
			«IF helperInfo.hasContext»[ObservableProxy(typeof(Proxies), "«helperInfo.getTransformedName»")]«ENDIF»
			public static «helperInfo.getTransformedReturnTypeName» «helperInfo.getTransformedName»(«IF helperInfo.hasContext»this «helperInfo.getTransformedContext» self«ENDIF»)
			{
				//attribute helper
				return «helperInfo.getTransformedExpression»;
			}
		'''

		return attributeHelperTemplate;
	}
}
