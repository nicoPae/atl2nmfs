package edu.kit.ipd.sdq.atl2nmfs.templates

import java.util.List

/**
 * The ReflectiveSynchronizationClassTemplate Class.
 */
class ReflectiveSynchronizationClassTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param transformationName
	 *            the transformation name
	 * @param inputModelContainerClassName
	 *            the input model container class name
	 * @param namespace
	 *            the namespace
	 * @param synchronizationRules
	 *            the transformed synchronization rules
	 * @return the created code as string
	 */
	def static String createCode(String transformationName, String inputModelContainerClassName, String namespace,
		List<String> synchronizationRules) {
		// we need the "using System.Globalization" import for the case that a double value is parsed
		// the InputModel property is needed to transform the OCL "allInstances" Operation
		// the InputModel property is static so all the inner classes can easily access it (C# inner classes behave differently to java inner classes)
		// TODO: only create the InputModel property when the OCL "allInstances" Operation is used in the transformation
		var reflectiveSynchronizationClassTemplate = '''
			using System;
			using System.Collections.Generic;
			using System.Globalization;
			using NMF.Expressions.Linq;
			using NMF.Synchronizations;
			using NMF.Transformations;
			using NMF.Utilities;
			using NMF.Models;
			
			namespace «namespace»
			{
			    public class «transformationName» : ReflectiveSynchronization
			    {
			    	public static «inputModelContainerClassName» «inputModelContainerClassName» { get; set; }
			    	
			    	«FOR synchronizationRule : synchronizationRules SEPARATOR "\n"»
			    	«synchronizationRule»
			    	«ENDFOR»
			    }
			}
		'''

		return reflectiveSynchronizationClassTemplate;
	}
}
