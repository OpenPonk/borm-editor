Class {
	#name : 'BormStateSimulationTest',
	#superclass : 'BormSimulationTest',
	#instVars : [
		'stateA',
		'participantA'
	],
	#category : 'OpenPonk-BormSimulation-Tests',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Tests'
}

{ #category : 'running' }
BormStateSimulationTest >> controllerClass [

	^ OPBormSimulator
]

{ #category : 'running' }
BormStateSimulationTest >> exampleModel [

	model := self emptyModel.
	participantA := self emptyParticipant.
	stateA := self emptyState.
	model
		add: participantA;
		add: stateA.

	^ model
]

{ #category : 'tests' }
BormStateSimulationTest >> testTransitionStepSimulation [

	| stateSimulatorA |
	stateSimulatorA := simulator simulatorOf: stateA.
	self assert: stateSimulatorA tokenCount equals: 1
]
