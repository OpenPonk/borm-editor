Class {
	#name : 'BormSimulationTest',
	#superclass : 'BormTest',
	#instVars : [
		'model',
		'simulator'
	],
	#category : 'OpenPonk-BormSimulation-Tests',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Tests'
}

{ #category : 'testing' }
BormSimulationTest class >> isAbstract [

	^ self == BormSimulationTest
]

{ #category : 'running' }
BormSimulationTest >> controllerClass [

	^ self subclassResponsibility
]

{ #category : 'running' }
BormSimulationTest >> exampleModel [

	^ self subclassResponsibility
]

{ #category : 'running' }
BormSimulationTest >> setUp [

	super setUp.
	model := self exampleModel.
	simulator := self controllerClass model: model
]
