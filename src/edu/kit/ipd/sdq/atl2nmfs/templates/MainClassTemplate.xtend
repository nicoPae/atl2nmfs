package edu.kit.ipd.sdq.atl2nmfs.templates

import java.util.List
import edu.kit.ipd.sdq.atl2nmfs.helper.infos.ModelInfo

/**
 * The MainClassTemplate Class.
 */
class MainClassTemplate {

	/**
	 * Creates the code.
	 * 
	 * @param transformationName
	 *            the transformation name
	 * @param mainClassName
	 *            the main class name
	 * @param mainRuleName
	 *            the main rule name
	 * @param inputModelContainerClassName
	 *            the input model container class name
	 * @param outputModelContainerClassName
	 *            the output model container class name
	 * @param namespace
	 *            the namespace
	 * @param inputModelInfos
	 *            the input model infos
	 * @param outputModelInfos
	 *            the output model infos
	 * @return the created code as string
	 */
	def static String createCode(String transformationName, String mainClassName, String mainRuleName,
		String inputModelContainerClassName, String outputModelContainerClassName, String namespace,
		List<ModelInfo> inputModelInfos, List<ModelInfo> outputModelInfos) {
			// remark: we have to use AppDomain.CurrentDomain.BaseDirectory instead of Environment.CurrentDirectory 
			// because if we run the program from a JUnit test the Environment.CurrentDirectory variable would 
			// point to the directory where the JUnit test was started not the C# program
			// the InputModelContainer property is needed to transform the OCL "allInstances" Operation
			// TODO: only create the InputModelContainer property when the OCL "allInstances" Operation is used in the transformation
			var mainClassTemplate = '''
				using System;
				using NMF.Models;
				using NMF.Synchronizations;
				using NMF.Transformations;
				using NMF.Models.Repository;
				using System.IO;
				
				namespace �namespace�
				{
				    class �mainClassName�
				    {
				        static void Main(string[] args)
				        {
				            if (args.Length != �inputModelInfos.size + outputModelInfos.size�)
				            {
				                Console.WriteLine("Wrong usage!");
				                Console.WriteLine(�inputModelInfos.size� + " input model paths and " + �outputModelInfos.size� + " output model paths are expected.");
				            }
				        	
				        	//absolute path is needed for the execution from a junit test
							�FOR i : 1 .. inputModelInfos.size�
							var absolutePathInputModel�i� = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, args[�i-1�]);
							�ENDFOR�		        	
							
							�FOR i : 1 .. outputModelInfos.size�
							var absoulutePathOutputModel�i� = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, args[�inputModelInfos.size+i-1�]);
							�ENDFOR�		
							
							//load input models
							var repository = new ModelRepository();
							�FOR i : 1 .. inputModelInfos.size�
							var inputModel�i� = repository.Resolve(absolutePathInputModel�i�);
							�ENDFOR�	
							
							//check if the input models exist
							�FOR i : 1 .. inputModelInfos.size�
							if(inputModel�i� == null)
								throw new FileNotFoundException("The �i�. input model with the path '" + absolutePathInputModel�i� + "' was not found");
							�ENDFOR�
							
							�FOR i : 1 .. outputModelInfos.size�
							var outputModel�i� = File.Exists(absoulutePathOutputModel�i�) ? repository.Resolve(absoulutePathOutputModel�i�) : new Model();
							�ENDFOR�				
							
							var inputModelContainer = new �inputModelContainerClassName�(�FOR i : 1 .. inputModelInfos.size SEPARATOR ', '�inputModel�i��ENDFOR�);
							var outputModelContainer = new �outputModelContainerClassName�(�FOR i : 1 .. outputModelInfos.size SEPARATOR ', '�outputModel�i��ENDFOR�);
										
							var direction = SynchronizationDirection.LeftToRight;
							var changePropagartion = ChangePropagationMode.OneWay;
							�transformationName� transformation = new �transformationName�();
							�transformationName�.�inputModelContainerClassName� = inputModelContainer;
				
							var context = transformation.Synchronize<�inputModelContainerClassName�, �outputModelContainerClassName�>(transformation.SynchronizationRule<�transformationName�.�mainRuleName�>(), ref inputModelContainer, ref outputModelContainer, direction, changePropagartion);
							
							var outputRepository = new ModelRepository();
							�FOR i : 1 .. outputModelInfos.size�
							outputRepository.Save(outputModelContainer.�outputModelInfos.get(i-1).name�, absoulutePathOutputModel�i�);
							�ENDFOR�							
						}
					}
				}
			'''

			return mainClassTemplate;
		}
	}
	