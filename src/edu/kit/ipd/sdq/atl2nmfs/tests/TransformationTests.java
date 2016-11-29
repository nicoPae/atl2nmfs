package edu.kit.ipd.sdq.atl2nmfs.tests;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import edu.kit.ipd.sdq.atl2nmfs.Atl2NmfSynchronizations;
import edu.kit.ipd.sdq.atl2nmfs.utils.MsBuildUtils;
import edu.kit.ipd.sdq.atl2nmfs.utils.ExecutionUtils;

/**
 * The TransformationTests Class.
 */
public class TransformationTests {

	/**
	 * Generate the NMF Synchronization code by executing the Atl2NmfS HOT,
	 * build and execute the created code.
	 *
	 * @param transformationName
	 *            the transformation name
	 * @param transformationPath
	 *            the transformation path
	 * @param outputPath
	 *            the output path
	 * @param inputMetamodelPaths
	 *            the input metamodel paths
	 * @param outputMetamodelPaths
	 *            the output metamodel paths
	 * @param inputModelPaths
	 *            the input model paths
	 * @param outputModelFileNames
	 *            the output model file names
	 */
	private void GenerateBuildExecute(String transformationName, String transformationPath, String outputPath,
			List<String> inputMetamodelPaths, List<String> outputMetamodelPaths, List<String> inputModelPaths,
			List<String> outputModelFileNames) {

		// execute the Atl2NmfS HOT
		try {
			Atl2NmfSynchronizations atl2NmfSynchronizations = new Atl2NmfSynchronizations();
			atl2NmfSynchronizations.doGenerate(transformationName, transformationPath, outputPath, inputMetamodelPaths,
					outputMetamodelPaths);
		} catch (Exception exception) {
			Assert.fail("Execution of the Atl2NmfS HOT failed. Exception message: " + exception.getMessage());
		}

		// build the created code of the Atl2NmfS HOT
		try {
			//in our test cases the project file path is a combination of the output path and the transformation name
			String projectFilePath = outputPath + "/" + transformationName + ".csproj";	
			MsBuildUtils.build(projectFilePath);
		} catch (Exception exception) {
			Assert.fail("Execution of MsBuild failed. Exception message: " + exception.getMessage());
		}
		
		//in these tests the output models do not exist yet. The synchronization will create them.
		//Therefore we create the paths where they should be created
		ArrayList<String> outputModelPaths = new ArrayList<String>();
		for(String outputModelFileName : outputModelFileNames) {
			outputModelPaths.add(outputPath + "/bin/" + outputModelFileName);
		}
		
		// execute the build code
		try {
			//in our test cases the executable file path is in the bin folder of the output path
			String executableFilePath = outputPath + "/bin/" + transformationName + ".exe";	
			ExecutionUtils.execute(executableFilePath, outputPath, inputModelPaths, outputModelPaths);
		} catch (Exception exception) {
			Assert.fail("Execution of the NMF Synchronizations failed. Exception message: " + exception.getMessage());
		}
		
		//check if all output models are created by the synchronization
		for(String outputModelPath : outputModelPaths) {
			Assert.assertTrue(new File(outputModelPath).exists());
		}
		
		//TODO: compare the created models with the models created by the ATL transformation
	}

	/**
	 * Families 2 persons with library test.
	 */
	@Test
	public void Families2PersonsWithLibraryTest() {
		String transformationName = "Families2PersonsWithLibrary";
		String transformationPath = "resources/Families2PersonsWithLibrary/Families2PersonsWithLibrary.atl";
		String outputPath = "generated/Families2PersonsWithLibrary.NMFSynchronizations";
		String inputMetamodelPath = "resources/Families2PersonsWithLibrary/Families.ecore";
		String outputMetamodelPath = "resources/Families2PersonsWithLibrary/Persons.ecore";
		String inputModelPath = "resources/Families2PersonsWithLibrary/SampleFamilies.xmi";
		String outputModelFileName = "SamplePersonsOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * Families 2 persons test.
	 */
	@Test
	public void Families2PersonsTest() {
		String transformationName = "Families2Persons";
		String transformationPath = "resources/Families2Persons/Families2Persons.atl";
		String outputPath = "generated/Families2Persons.NMFSynchronizations";
		String inputMetamodelPath = "resources/Families2Persons/Families.ecore";
		String outputMetamodelPath = "resources/Families2Persons/Persons.ecore";
		String inputModelPath = "resources/Families2Persons/SampleFamilies.xmi";
		String outputModelFileName = "SamplePersonsOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * Test transformation test.
	 */
	@Test
	public void TestTransformationTest() {
		String transformationName = "TestTransformation";
		String transformationPath = "resources/TestTransformation/TestTransformation.atl";
		String outputPath = "generated/TestTransformation.NMFSynchronizations";
		String inputMetamodelPath = "resources/TestTransformation/Families.ecore";
		String outputMetamodelPath = "resources/TestTransformation/Persons.ecore";
		String inputModelPath = "resources/TestTransformation/SampleFamilies.xmi";
		String outputModelFileName = "SamplePersonsOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * A 2 B containment test.
	 */
	@Test
	public void A2BContainmentTest() {
		String transformationName = "A2BContainment";
		String transformationPath = "resources/A2BContainment/A2BContainment.atl";
		String outputPath = "generated/A2BContainment.NMFSynchronizations";
		String inputMetamodelPath = "resources/A2BContainment/TypeA.ecore";
		String outputMetamodelPath = "resources/A2BContainment/TypeB.ecore";
		String inputModelPath = "resources/A2BContainment/SampleInput.xmi";
		String outputModelFileName = "SampleOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * Petri net 2 grafcet test.
	 */
	@Test
	public void PetriNet2GrafcetTest() {
		String transformationName = "PetriNet2Grafcet";
		String transformationPath = "resources/PetriNet2Grafcet/PetriNet2Grafcet.atl";
		String outputPath = "generated/PetriNet2Grafcet.NMFSynchronizations";
		String inputMetamodelPath = "resources/PetriNet2Grafcet/PetriNet.ecore";
		String outputMetamodelPath = "resources/PetriNet2Grafcet/Grafcet.ecore";
		String inputModelPath = "resources/PetriNet2Grafcet/SamplePetriNet.xmi";
		String outputModelFileName = "SampleGrafcetOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * PetriNet 2 PathExp test.
	 */
	@Test
	public void PetriNet2PathExpTest() {
		String transformationName = "PetriNet2PathExp";
		String transformationPath = "resources/PetriNet2PathExp/PetriNet2PathExp.atl";
		String outputPath = "generated/PetriNet2PathExp.NMFSynchronizations";
		String inputMetamodelPath = "resources/PetriNet2PathExp/PetriNet.ecore";
		String outputMetamodelPath = "resources/PetriNet2PathExp/PathExp.ecore";
		String inputModelPath = "resources/PetriNet2PathExp/SamplePetrinet.xmi";
		String outputModelFileName = "SamplePathExpOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * A 2 B multiple input and output test.
	 */
	@Test
	public void A2BMultipleInputAndOutputTest() {
		String transformationName = "A2BMultipleInputAndOutput";
		String transformationPath = "resources/A2BMultipleInputAndOutput/A2BMultipleInputAndOutput.atl";
		String outputPath = "generated/A2BMultipleInputAndOutput.NMFSynchronizations";

		List<String> inputMetamodelPaths = new ArrayList<String>();
		inputMetamodelPaths.add("resources/A2BMultipleInputAndOutput/TypeA.ecore");
		inputMetamodelPaths.add("resources/A2BMultipleInputAndOutput/TypeB.ecore");

		List<String> outputMetamodelPaths = new ArrayList<String>();
		outputMetamodelPaths.add("resources/A2BMultipleInputAndOutput/TypeC.ecore");
		outputMetamodelPaths.add("resources/A2BMultipleInputAndOutput/TypeD.ecore");

		List<String> inputModelPaths = new ArrayList<String>();
		inputModelPaths.add("resources/A2BMultipleInputAndOutput/SampleInputTypeA.xmi");
		inputModelPaths.add("resources/A2BMultipleInputAndOutput/SampleInputTypeB1.xmi");
		inputModelPaths.add("resources/A2BMultipleInputAndOutput/SampleInputTypeB2.xmi");

		List<String> outputModelFileNames = new ArrayList<String>();
		outputModelFileNames.add("SampleOutputTypeC.xmi");
		outputModelFileNames.add("SampleOutputTypeD.xmi");

		GenerateBuildExecute(transformationName, transformationPath, outputPath, inputMetamodelPaths,
				outputMetamodelPaths, inputModelPaths, outputModelFileNames);
	}

	/**
	 * A 2 B multiple output test.
	 */
	@Test
	public void A2BMultipleOutputTest() {
		String transformationName = "A2BMultipleOutput";
		String transformationPath = "resources/A2BMultipleOutput/A2BMultipleOutput.atl";
		String outputPath = "generated/A2BMultipleOutput.NMFSynchronizations";

		String inputMetamodelPath = "resources/A2BMultipleOutput/TypeA.ecore";

		List<String> outputMetamodelPaths = new ArrayList<String>();
		outputMetamodelPaths.add("resources/A2BMultipleOutput/TypeB.ecore");
		outputMetamodelPaths.add("resources/A2BMultipleOutput/TypeC.ecore");

		String inputModelPath = "resources/A2BMultipleOutput/SampleInput.xmi";

		List<String> outputModelFileNames = new ArrayList<String>();
		outputModelFileNames.add("SampleOutputTypeB.xmi");
		outputModelFileNames.add("SampleOutputTypeC.xmi");

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				outputMetamodelPaths, Arrays.asList(inputModelPath), outputModelFileNames);
	}

	/**
	 * A 2 B multiple input different type test.
	 */
	@Test
	public void A2BMultipleInputDifferentTypeTest() {
		String transformationName = "A2BMultipleInputDifferentType";
		String transformationPath = "resources/A2BMultipleInputDifferentType/A2BMultipleInputDifferentType.atl";
		String outputPath = "generated/A2BMultipleInputDifferentType.NMFSynchronizations";

		List<String> inputMetamodelPaths = new ArrayList<String>();
		inputMetamodelPaths.add("resources/A2BMultipleInputDifferentType/TypeA.ecore");
		inputMetamodelPaths.add("resources/A2BMultipleInputDifferentType/TypeC.ecore");

		String outputMetamodelPath = "resources/A2BMultipleInputDifferentType/TypeB.ecore";

		List<String> inputModelPaths = new ArrayList<String>();
		inputModelPaths.add("resources/A2BMultipleInputDifferentType/SampleInputTypeA.xmi");
		inputModelPaths.add("resources/A2BMultipleInputDifferentType/SampleInputTypeC.xmi");

		String outputModelFileName = "SampleOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, inputMetamodelPaths,
				Arrays.asList(outputMetamodelPath), inputModelPaths, Arrays.asList(outputModelFileName));
	}

	/**
	 * A 2 B multiple input same type test.
	 */
	@Test
	public void A2BMultipleInputSameTypeTest() {
		String transformationName = "A2BMultipleInputSameType";
		String transformationPath = "resources/A2BMultipleInputSameType/A2BMultipleInputSameType.atl";
		String outputPath = "generated/A2BMultipleInputSameType.NMFSynchronizations";

		String inputMetamodelPath = "resources/A2BMultipleInputSameType/TypeA.ecore";
		String outputMetamodelPath = "resources/A2BMultipleInputSameType/TypeB.ecore";

		List<String> inputModelPaths = new ArrayList<String>();
		inputModelPaths.add("resources/A2BMultipleInputSameType/SampleInput1.xmi");
		inputModelPaths.add("resources/A2BMultipleInputSameType/SampleInput2.xmi");

		String outputModelFileName = "SampleOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), inputModelPaths, Arrays.asList(outputModelFileName));
	}

	/**
	 * A 2 B helper without context test.
	 */
	@Test
	public void A2BHelperWithoutContextTest() {
		String transformationName = "A2BHelperWithoutContext";
		String transformationPath = "resources/A2BHelperWithoutContext/A2BHelperWithoutContext.atl";
		String outputPath = "generated/A2BHelperWithoutContext.NMFSynchronizations";
		String inputMetamodelPath = "resources/A2BHelperWithoutContext/TypeA.ecore";
		String outputMetamodelPath = "resources/A2BHelperWithoutContext/TypeB.ecore";
		String inputModelPath = "resources/A2BHelperWithoutContext/SampleInput.xmi";
		String outputModelFileName = "SampleOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * Port V 4 ref immediate composite test.
	 */
	@Test
	public void PortV4RefImmediateCompositeTest() {
		String transformationName = "PortV4";
		String transformationPath = "resources/PortV4/PortV4.atl";
		String outputPath = "generated/PortV4.NMFSynchronizations";
		String inputMetamodelPath = "resources/PortV4/TypeA.ecore";
		String outputMetamodelPath = "resources/PortV4/TypeB.ecore";
		String inputModelPath = "resources/PortV4/SampleInput.xmi";
		String outputModelFileName = "SampleOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * Port V 3 all instances test.
	 */
	@Test
	public void PortV3AllInstancesTest() {
		String transformationName = "PortV3";
		String transformationPath = "resources/PortV3/PortV3.atl";
		String outputPath = "generated/PortV3.NMFSynchronizations";
		String inputMetamodelPath = "resources/PortV3/TypeA.ecore";
		String outputMetamodelPath = "resources/PortV3/TypeB.ecore";
		String inputModelPath = "resources/PortV3/SampleInput.xmi";
		String outputModelFileName = "SampleOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * Port V 2 lazy rules test.
	 */
	@Test
	public void PortV2LazyRulesTest() {
		String transformationName = "PortV2";
		String transformationPath = "resources/PortV2/PortV2.atl";
		String outputPath = "generated/PortV2.NMFSynchronizations";
		String inputMetamodelPath = "resources/PortV2/TypeA.ecore";
		String outputMetamodelPath = "resources/PortV2/TypeB.ecore";
		String inputModelPath = "resources/PortV2/SampleInput.xmi";
		String outputModelFileName = "SampleOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * Petri net 2 PNML test.
	 */
	@Test
	public void PetriNet2PNMLTest() {
		String transformationName = "PetriNet2PNML";
		String transformationPath = "resources/PetriNet2PNML/PetriNet2PNML.atl";
		String outputPath = "generated/PetriNet2PNML.NMFSynchronizations";
		String inputMetamodelPath = "resources/PetriNet2PNML/PetriNet.ecore";
		String outputMetamodelPath = "resources/PetriNet2PNML/PNML.ecore";
		String inputModelPath = "resources/PetriNet2PNML/SampleInput.xmi";
		String outputModelFileName = "SampleOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}

	/**
	 * Inheritance test.
	 */
	@Test
	public void InheritanceTest() {
		String transformationName = "Inheritance";
		String transformationPath = "resources/Inheritance/Inheritance.atl";
		String outputPath = "generated/Inheritance.NMFSynchronizations";
		String inputMetamodelPath = "resources/Inheritance/TypeA.ecore";
		String outputMetamodelPath = "resources/Inheritance/TypeB.ecore";
		String inputModelPath = "resources/Inheritance/SampleInput.xmi";
		String outputModelFileName = "SampleOutput.xmi";

		GenerateBuildExecute(transformationName, transformationPath, outputPath, Arrays.asList(inputMetamodelPath),
				Arrays.asList(outputMetamodelPath), Arrays.asList(inputModelPath), Arrays.asList(outputModelFileName));
	}
}
