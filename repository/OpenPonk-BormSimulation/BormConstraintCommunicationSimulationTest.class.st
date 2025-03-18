Class {
	#name : 'BormConstraintCommunicationSimulationTest',
	#superclass : 'BormSimulationTest',
	#instVars : [
		'participantA',
		'participantB',
		'activityA',
		'activityB',
		'communication',
		'constraint'
	],
	#category : 'OpenPonk-BormSimulation-Tests',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Tests'
}

{ #category : 'tests' }
BormConstraintCommunicationSimulationTest >> controllerClass [

	^ OPBormSimulator
]

{ #category : 'running' }
BormConstraintCommunicationSimulationTest >> exampleModel [

	model := self emptyModel.
	participantA := self emptyParticipant.
	participantB := self emptyParticipant.
	activityA := self emptyActivity.
	activityB := self emptyActivity.
	communication := self emptyCommunication.
	constraint := self emptyConstraint.
	communication from: activityA to: activityB.
	model
		add: participantA;
		add: activityA.
	model
		add: participantB;
		add: activityB;
		add: communication;
		add: constraint.
	communication constraint: constraint.
	activityA send: communication.
	activityB receive: communication.

	^ model
]

{ #category : 'tests' }
BormConstraintCommunicationSimulationTest >> testCommunicationConstraintStepSimulationFalse [

	| activitySimulatorA activitySimulatorB constraintSimulator |
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	constraintSimulator := simulator simulatorOf: constraint.
	constraintSimulator value: false.
	self assert: activitySimulatorA tokenCount equals: 1.
	self assert: activitySimulatorB tokenCount equals: 0.
	simulator step.
	self assert: activitySimulatorA tokenCount equals: 1.
	self assert: activitySimulatorB tokenCount equals: 0
]

{ #category : 'tests' }
BormConstraintCommunicationSimulationTest >> testCommunicationConstraintStepSimulationTrue [

	| activitySimulatorA activitySimulatorB constraintSimulator |
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	constraintSimulator := simulator simulatorOf: constraint.
	constraintSimulator value: true.
	self assert: activitySimulatorA tokenCount equals: 1.
	self assert: activitySimulatorB tokenCount equals: 0.
	simulator step.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 1
]
