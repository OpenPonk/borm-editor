"
I am an integration test class verifying that the BORM Data Flows example model survives roundtrip serialization (save and load) without data loss or corruption.
"
Class {
	#name : 'OPBormDataFlowsExamplePersistenceTest',
	#superclass : 'OPExamplePersistenceTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'hooks' }
OPBormDataFlowsExamplePersistenceTest >> createExampleModel [

	^ OPBormExampleDiagrams exampleDataFlows
]
