"
Abstract base class for unit tests verifying the behavior of BORM model simulation components.
"
Class {
	#name : 'BormSimulationTest',
	#superclass : 'BormTest',
	#instVars : [
		'model',
		'simulator'
	],
	#category : 'OpenPonk-BormSimulation-Tests-Simulation',
	#package : 'OpenPonk-BormSimulation-Tests',
	#tag : 'Simulation'
}

{ #category : 'testing' }
BormSimulationTest class >> isAbstract [

	^ self == BormSimulationTest
]

{ #category : 'running' }
BormSimulationTest >> exampleModel [

	^ self subclassResponsibility
]

{ #category : 'running' }
BormSimulationTest >> setUp [

	super setUp.
	model := self exampleModel.
	simulator := self simulatorClass model: model
]

{ #category : 'running' }
BormSimulationTest >> simulatorClass [

	^ self subclassResponsibility
]
