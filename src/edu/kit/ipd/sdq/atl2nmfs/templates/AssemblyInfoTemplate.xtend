package edu.kit.ipd.sdq.atl2nmfs.templates

import java.util.List
import edu.kit.ipd.sdq.atl2nmfs.helper.infos.MetamodelInfo

/**
 * The AssemblyInfoTemplate Class.
 */
class AssemblyInfoTemplate {	
	
  /**
	 * Creates the code.
	 *
	 * @param title
	 *            the title
	 * @param combinedMetamodelInfos
	 *            the combined metamodel infos
	 * @param namespace
	 *            the namespace
	 * @return the created code as string
	 */
	def static String createCode(String title, List<MetamodelInfo> combinedMetamodelInfos, String namespace) {
		var assemblyInfoTemplate = '''
			using System.Reflection;
			using System.Runtime.CompilerServices;
			using System.Runtime.InteropServices;
			using NMF.Models;

			[assembly: AssemblyTitle("�title�")]
			[assembly: AssemblyDescription("")]
			[assembly: AssemblyConfiguration("")]
			[assembly: AssemblyCompany("")]
			[assembly: AssemblyProduct("�title�")]
			[assembly: AssemblyCopyright("Copyright �  2016")]
			[assembly: AssemblyTrademark("")]
			[assembly: AssemblyCulture("")]
			[assembly: ComVisible(false)]
			[assembly: AssemblyVersion("1.0.0.0")]
			[assembly: AssemblyFileVersion("1.0.0.0")]

			�FOR metamodelInfo : combinedMetamodelInfos�
			[assembly: ModelMetadata("�metamodelInfo.nsUri�", "�namespace�.�metamodelInfo.nmfFileName�")]
			�ENDFOR�
		'''
		
		return assemblyInfoTemplate;
	}
}
