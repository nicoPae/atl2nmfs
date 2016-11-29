package edu.kit.ipd.sdq.atl2nmfs.templates

import java.util.List

/**
 * The ProjectTemplate Class.
 */
class ProjectTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param files
	 *            the files
	 * @param embeddedFiles
	 *            the embedded files
	 * @param namespace
	 *            the namespace
	 * @param assemblyName
	 *            the assembly name
	 * @return the created code as string
	 */
	def static String createCode(List<String> files, List<String> embeddedFiles,
		String namespace, String assemblyName) {

		// TODO: register clean job?
		// for debugging build:
		// <DebugSymbols>true</DebugSymbols>
		// <DebugType>full</DebugType>
		// <Optimize>false</Optimize>
		// <DefineConstants>DEBUG;TRACE</DefineConstants>
		// for release build:
		// <DebugType>pdbonly</DebugType>
		// <Optimize>true</Optimize>
		// <DefineConstants>TRACE</DefineConstants>
		var projectTemplate = '''
			<?xml version="1.0" encoding="utf-8"?>
			<Project ToolsVersion="14.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
			    <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')" />
			    <PropertyGroup>
			        <PlatformTarget>AnyCPU</PlatformTarget>
			        <RootNamespace>�namespace�</RootNamespace>
			        <AssemblyName>�assemblyName�</AssemblyName>
			        <OutputPath>bin\</OutputPath>
			        <OutputType>Exe</OutputType>
			        
					<DebugSymbols>true</DebugSymbols>
					   <DebugType>full</DebugType>
					   <Optimize>false</Optimize>
					   <DefineConstants>DEBUG;TRACE</DefineConstants>
					      
					      <ErrorReport>prompt</ErrorReport>
					      <WarningLevel>4</WarningLevel>
					  </PropertyGroup>
					  <ItemGroup>
					   <Reference Include="NMF.Collections">
					     <HintPath>Libs\NMF.Collections.dll</HintPath>
					   </Reference>
					   <Reference Include="NMF.Expressions">
					     <HintPath>Libs\NMF.Expressions.dll</HintPath>
					   </Reference>
					   <Reference Include="NMF.Expressions.Linq">
					     <HintPath>Libs\NMF.Expressions.Linq.dll</HintPath>
					   </Reference>
					   <Reference Include="NMF.Models">
					     <HintPath>Libs\NMF.Models.dll</HintPath>
					   </Reference>
					   <Reference Include="NMF.Serialization">
					     <HintPath>Libs\NMF.Serialization.dll</HintPath>
					   </Reference>
					   <Reference Include="NMF.Synchronizations">
					     <HintPath>Libs\NMF.Synchronizations.dll</HintPath>
					   </Reference>
					   <Reference Include="NMF.Transformations">
					     <HintPath>Libs\NMF.Transformations.dll</HintPath>
					   </Reference>
					   <Reference Include="NMF.Transformations.Core">
					     <HintPath>Libs\NMF.Transformations.Core.dll</HintPath>
					   </Reference>
					   <Reference Include="NMF.Utilities">
					     <HintPath>Libs\NMF.Utilities.dll</HintPath>
					   </Reference>
					      <Reference Include="System" />
					      <Reference Include="System.Core" />
					      <Reference Include="System.Data" />
					      <Reference Include="System.Data.DataSetExtensions" />
					      <Reference Include="Microsoft.CSharp" />
					      <Reference Include="System.Xml" />
					      <Reference Include="System.Xml.Linq" />
					  </ItemGroup>
					  <ItemGroup>
					  	�FOR file : files�
					  	<Compile Include="�file�" />
					  	�ENDFOR�
					  </ItemGroup>
					  <ItemGroup>
					  	�FOR embeddedfile : embeddedFiles�
					  	<EmbeddedResource Include="�embeddedfile�" />
					  	�ENDFOR�
					  </ItemGroup>
					  <ItemGroup>
					</ItemGroup>
					<Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets" />
			</Project>
		'''

		return projectTemplate;
	}
}
