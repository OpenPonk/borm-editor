Class {
	#name : 'BormTransitionSimulationTest',
	#superclass : 'BormSimulationTest',
	#instVars : [
		'participantA',
		'stateA',
		'stateB',
		'transition'
	],
	#category : 'OpenPonk-BormSimulation-Tests',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Tests'
}

{ #category : 'tests' }
BormTransitionSimulationTest >> controllerClass [

	^ OPBormSimulator
]

{ #category : 'running' }
BormTransitionSimulationTest >> exampleModel [

	model := self emptyModel.
	participantA := self emptyParticipant.
	stateA := self emptyState.
	stateB := self emptyState.
	transition := self emptyTransition.
	transition from: stateA to: stateB.
	model
		add: participantA;
		add: stateA;
		add: transition.
	participantA add: stateB.

	^ model
]

{ #category : 'tests' }
BormTransitionSimulationTest >> testTransitionStepSimulation [

	|   stateSimulatorA stateSimulatorB |
	stateSimulatorA := simulator simulatorOf: stateA.
	stateSimulatorB := simulator simulatorOf: stateB.
	self assert: stateSimulatorA tokenCount equals: 1.
	self assert: stateSimulatorB tokenCount equals: 0.
	simulator step.
	self assert: stateSimulatorA tokenCount equals: 0.
	self assert: stateSimulatorB tokenCount equals: 1
]
