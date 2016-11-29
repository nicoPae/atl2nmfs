package edu.kit.ipd.sdq.atl2nmfs.templates

import edu.kit.ipd.sdq.atl2nmfs.helper.infos.HelperInfo
import org.apache.commons.lang.WordUtils

/**
 * The AttributeHelperProxyTemplate Class.
 */
class AttributeHelperProxyTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param helperInfo
	 *            the helper info
	 * @return the created code as string
	 */
	def static String createCode(HelperInfo helperInfo) {
		// ATL attribute helpers can't have parameters
		var uncapitalizedName = WordUtils.uncapitalize(helperInfo.getTransformedName);

		// it is important that the parameter name "self" is used because this name is used in the expression
		var attributeHelperProxyTemplate = '''
			private static ObservingFunc<«helperInfo.getTransformedContext», «helperInfo.getTransformedReturnTypeName»> «uncapitalizedName»Func = new ObservingFunc<«helperInfo.getTransformedContext», «helperInfo.getTransformedReturnTypeName»>(
			    self => «helperInfo.getTransformedExpression»);
			
			public static INotifyValue<«helperInfo.getTransformedReturnTypeName»> «helperInfo.getTransformedName»(INotifyValue<«helperInfo.getTransformedContext»> self)
			{
			    return «uncapitalizedName»Func.Observe(self);
			}
		'''

		return attributeHelperProxyTemplate;
	}
}
		