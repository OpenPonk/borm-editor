Class {
	#name : 'OPBormToken',
	#superclass : 'OPToken',
	#instVars : [
		'type'
	],
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'initialization' }
OPBormToken >> initialize [

	super initialize.
	type := 'OPBormTransitionSimulator'
]

{ #category : 'testing' }
OPBormToken >> isSimulable [
	^ false
]

{ #category : 'testing' }
OPBormToken >> isSteppable [
	^ false
]

{ #category : 'accessing' }
OPBormToken >> type [
	^ type
]

{ #category : 'accessing' }
OPBormToken >> type: aType [
	type := aType
]
