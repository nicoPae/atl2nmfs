package edu.kit.ipd.sdq.atl2nmfs.templates

import edu.kit.ipd.sdq.atl2nmfs.helper.infos.RuleInfo
import edu.kit.ipd.sdq.atl2nmfs.helper.infos.BindingInfo

/**
 * The SynchronizeTemplate Class.
 */
class SynchronizeTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param containingRuleInfo
	 *            the containing rule info
	 * @param bindingInfo
	 *            the binding info
	 * @return the created code as string
	 */
	def static String createCode(RuleInfo containingRuleInfo, BindingInfo bindingInfo) {
		return createTemplateCode(null, containingRuleInfo, bindingInfo, bindingInfo.transformedDefaultExpression, false,
			false)
	}

	/**
	 * Creates the code.
	 * 
	 * @param callingRuleInfo
	 *            the calling rule info
	 * @param containingRuleInfo
	 *            the containing rule info
	 * @param bindingInfo
	 *            the binding info
	 * @param bindingExpression
	 *            the transformed binding expression
	 * @param inputCast
	 *            indicating if an input cast is required
	 * @param outputCast
	 *            indicating if an output cast is required
	 * @return the created code as string
	 */
	def static String createCode(RuleInfo callingRuleInfo, RuleInfo containingRuleInfo, BindingInfo bindingInfo,
		String bindingExpression, Boolean inputCast, Boolean outputCast) {
		return createTemplateCode(callingRuleInfo, containingRuleInfo, bindingInfo, bindingExpression, inputCast,
			outputCast)
	}

	/**
	 * Creates the template code.
	 * 
	 * @param callingRuleInfo
	 *            the calling rule info
	 * @param containingRuleInfo
	 *            the containing rule info
	 * @param bindingInfo
	 *            the binding info
	 * @param bindingExpression
	 *            the transformed binding expression
	 * @param inputCast
	 *            indicating if an input cast is required
	 * @param outputCast
	 *            indicating if an output cast is required
	 * @return the created code as string
	 */
	def private static String createTemplateCode(RuleInfo callingRuleInfo, RuleInfo containingRuleInfo,
		BindingInfo bindingInfo, String bindingExpression, Boolean inputCast, Boolean outputCast) {
		// extracted some information to be able to create a more readable template expression
		var inPatternVariableName = containingRuleInfo.inputVariableName;
		var outPatternVariableName = containingRuleInfo.outputVariableName;

		var outputPropertyName = bindingInfo.transformedOutputPropertyName;

		val ruleInputReturnTypeInfo = bindingInfo.inputReturnTypeInfo;
		val ruleOutputReturnTypeInfo = bindingInfo.outputReturnTypeInfo;

		var isInputElementACollection = ruleInputReturnTypeInfo.getIsTypeCollection;
		var isOutputElementACollection = ruleOutputReturnTypeInfo.getIsTypeCollection;

		var hasRule = callingRuleInfo != null;
		var hasFilter = hasRule && callingRuleInfo.getHasFilter;

		var filterName = if(hasFilter) callingRuleInfo.filterName else "";
		var ruleName = if(hasRule) callingRuleInfo.name else "";
		var expectedInputType = if(inputCast) callingRuleInfo.getTransformedInputTypeName else "";
		var expectedOutputType = if (outputCast)
				callingRuleInfo.
					getTransformedOutputTypeName
			else
				"";

		var binding = bindingExpression;
		if (isInputElementACollection) {
			// remark: this should normally never happen but since ATL allows such a case and only prints a warning we have to consider it
			binding = '''«binding».FirstOrDefault()''';
		}

		var outputExpression = '''«outPatternVariableName».«outputPropertyName»'''
		if (isOutputElementACollection) {
			outputExpression = '''«outputExpression».FirstOrDefault()''';
		}

		// IntelliSense Bug: if we call another rule we have to pass a filter (when no filter is used we have to pass null) 
		// if not IntelliSense believes the SyncRule is the left selector and the left selector is the right selector and so on
		var synchronizeTemplate = '''
			SynchronizeLeftToRightOnly(«IF hasRule»SyncRule<«ruleName»>(),«ENDIF»
				«inPatternVariableName» => «IF inputCast»«binding» as «expectedInputType»«ELSE»«binding»«ENDIF»,
				«outPatternVariableName» => «IF outputCast»«outputExpression» as «expectedOutputType»«ELSE»«outputExpression»«ENDIF»«IF hasRule»,«ELSE»);«ENDIF»
				«IF hasFilter»«inPatternVariableName» => «binding».«filterName»());«ENDIF»«IF !hasFilter && hasRule»null);«ENDIF»
		'''

		return synchronizeTemplate;
	}
}
