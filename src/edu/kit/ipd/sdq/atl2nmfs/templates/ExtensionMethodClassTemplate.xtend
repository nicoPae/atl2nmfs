package edu.kit.ipd.sdq.atl2nmfs.templates

import java.util.List

/**
 * The ExtensionMethodClassTemplate Class.
 */
class ExtensionMethodClassTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param namespace
	 *            the namespace
	 * @param className
	 *            the class name
	 * @param extensionMethods
	 *            the transformed extension methods
	 * @param proxies
	 *            the transformed proxies
	 * @return the created code as string
	 */
	def static String createCode(String namespace, String className, List<String> extensionMethods,
		List<String> proxies) {
		// we need the "using System.Globalization" import for the case that the parse double operation is used
		// we need the "using NMF.Models" import for the case that a OCL allInstances operation is used
		// since this class is specified in the same namespace as the rest of the program no import is required to use it
		var extensionMethodeClassTemplate = '''
			using System;
			using System.Globalization;
			using System.Linq;
			using NMF.Expressions;
			using NMF.Expressions.Linq;
			using NMF.Models;
			
			namespace �namespace�
			{
			    public static class �className�
			    {
			    	�FOR extensionMethod : extensionMethods�
			    	
			    	�extensionMethod�
			    	
			    	�ENDFOR�
			    	
			    	private class Proxies
			    	{
			    		�FOR proxy : proxies�
			    		
			    		�proxy�
			    		
			    		�ENDFOR�
			    	}
			    }
			}
		'''

		return extensionMethodeClassTemplate;
	}
}
