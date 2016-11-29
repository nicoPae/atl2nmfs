package edu.kit.ipd.sdq.atl2nmfs.templates

import edu.kit.ipd.sdq.atl2nmfs.helper.infos.RuleInfo
import org.apache.commons.lang.WordUtils

/**
 * The FilterProxyTemplate Class.
 */
class FilterProxyTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param ruleInfo
	 *            the rule info
	 * @return the created code as string
	 */
	def static String createCode(RuleInfo ruleInfo) {
		var uncapitalizedFilterName = WordUtils.uncapitalize(ruleInfo.filterName);

		// the return type of a filter expression is always bool
		// it is important that the parameter name "self" is used because this name is used in the expression
		var filterProxyTemplate = '''
			private static ObservingFunc<«ruleInfo.getTransformedInputTypeName», bool> «uncapitalizedFilterName»Func = new ObservingFunc<«ruleInfo.getTransformedInputTypeName», bool>(
			    «ruleInfo.inputVariableName» => «ruleInfo.getTransformedFilterExpression»);
			
			public static INotifyValue<bool> «ruleInfo.filterName»(INotifyValue<«ruleInfo.getTransformedInputTypeName»> self)
			{
			    return «uncapitalizedFilterName»Func.Observe(self);
			}
		'''

		return filterProxyTemplate;
	}
}
		