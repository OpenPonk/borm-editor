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
