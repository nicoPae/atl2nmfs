package edu.kit.ipd.sdq.atl2nmfs.templates

import java.util.List
import edu.kit.ipd.sdq.atl2nmfs.helper.infos.RuleInfo

/**
 * The SynchronizationRuleClassTemplate Class.
 */
class SynchronizationRuleClassTemplate {

	/**
	 * Creates the main rule code.
	 * 
	 * @param ruleName
	 *            the rule name
	 * @param inputType
	 *            the input type
	 * @param outputType
	 *            the output type
	 * @param bindings
	 *            the transformed bindings
	 * @return the created code as string
	 */
	def static String createMainRuleCode(String ruleName, String inputType, String outputType, List<String> bindings) {
		return createCode(ruleName, inputType, outputType, bindings);
	}

	/**
	 * Creates the code.
	 * 
	 * @param ruleInfo
	 *            the rule info
	 * @param bindings
	 *            the transformed bindings
	 * @return the created code as string
	 */
	def static String createCode(RuleInfo ruleInfo, List<String> bindings) {
		return createCode(ruleInfo.name, ruleInfo.getTransformedInputTypeName, ruleInfo.getTransformedOutputTypeName,
			bindings);
	}

	/**
	 * Creates the code.
	 * 
	 * @param ruleName
	 *            the rule name
	 * @param inputType
	 *            the input type
	 * @param outputType
	 *            the output type
	 * @param bindings
	 *            the transformed bindings
	 * @return the created code as string
	 */
	def private static String createCode(String ruleName, String inputType, String outputType, List<String> bindings) {
		var reflectiveSynchronizationClassTemplate = '''
			public class «ruleName» : SynchronizationRule<«inputType», «outputType»>
			{
			    public override void DeclareSynchronization()
			    {
			    	«FOR binding : bindings SEPARATOR "\n"»
			    	«binding»
			    	«ENDFOR»
			    }
			}
		'''

		return reflectiveSynchronizationClassTemplate;
	}
}
