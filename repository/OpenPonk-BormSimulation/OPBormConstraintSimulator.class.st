Class {
	#name : 'OPBormConstraintSimulator',
	#superclass : 'OPElementSimulator',
	#instVars : [
		'value'
	],
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'initialization' }
OPBormConstraintSimulator >> initialize [

	super initialize.
	value := false
]

{ #category : 'testing' }
OPBormConstraintSimulator >> isSimulable [

	^ false
]

{ #category : 'evaluating' }
OPBormConstraintSimulator >> value [

	^ value
]

{ #category : 'evaluating' }
OPBormConstraintSimulator >> value: aValue [

	value := aValue
]
