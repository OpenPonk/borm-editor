"
Unit tests verifying transition steps in a BORM simulation when constrained by specific boolean conditions (true or false).
"
Class {
	#name : 'BormConstraintTransitionSimulationTest',
	#superclass : 'BormSimulationTest',
	#instVars : [
		'participantA',
		'stateA',
		'stateB',
		'transition',
		'constraint'
	],
	#category : 'OpenPonk-BormSimulation-Tests',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Tests'
}

{ #category : 'running' }
BormConstraintTransitionSimulationTest >> controllerClass [

	^ OPBormSimulator
]

{ #category : 'running' }
BormConstraintTransitionSimulationTest >> exampleModel [

	model := self emptyModel.
	participantA := self emptyParticipant.
	stateA := self emptyState.
	stateB := self emptyState.
	transition := self emptyTransition.
	constraint := self emptyConstraint.
	transition from: stateA to: stateB.
	model
		add: participantA;
		add: stateA.
	participantA
		add: stateB;
		add: transition;
		add: constraint.
	transition constraint: constraint.

	^ model
]

{ #category : 'tests' }
BormConstraintTransitionSimulationTest >> testTransitionConstraintStepSimulationFalse [

	| stateSimulatorA stateSimulatorB constraintSimulator |
	stateSimulatorA := simulator simulatorOf: stateA.
	stateSimulatorB := simulator simulatorOf: stateB.
	constraintSimulator := simulator simulatorOf: constraint.
	constraintSimulator value: false.
	self assert: stateSimulatorA tokenCount equals: 1.
	self assert: stateSimulatorB tokenCount equals: 0.
	simulator step.
	self assert: stateSimulatorA tokenCount equals: 1.
	self assert: stateSimulatorB tokenCount equals: 0
]

{ #category : 'tests' }
BormConstraintTransitionSimulationTest >> testTransitionConstraintStepSimulationTrue [

	| stateSimulatorA stateSimulatorB constraintSimulator |
	stateSimulatorA := simulator simulatorOf: stateA.
	stateSimulatorB := simulator simulatorOf: stateB.
	constraintSimulator := simulator simulatorOf: constraint.
	constraintSimulator value: true.
	self assert: stateSimulatorA tokenCount equals: 1.
	self assert: stateSimulatorB tokenCount equals: 0.
	simulator step.
	self assert: stateSimulatorA tokenCount equals: 0.
	self assert: stateSimulatorB tokenCount equals: 1
]
