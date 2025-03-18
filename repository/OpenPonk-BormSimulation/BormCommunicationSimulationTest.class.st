Class {
	#name : 'BormCommunicationSimulationTest',
	#superclass : 'BormSimulationTest',
	#instVars : [
		'activity',
		'state',
		'communication',
		'participant',
		'participantA',
		'participantB',
		'activityA',
		'activityB'
	],
	#category : 'OpenPonk-BormSimulation-Tests',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Tests'
}

{ #category : 'running' }
BormCommunicationSimulationTest >> controllerClass [

	^ OPBormSimulator
]

{ #category : 'running' }
BormCommunicationSimulationTest >> exampleModel [

	model := self emptyModel.
	participantA := self emptyParticipant.
	participantB := self emptyParticipant.
	activityA := self emptyActivity.
	activityB := self emptyActivity.
	communication := self emptyCommunication.
	communication from: activityA to: activityB.
	model
		add: participantA;
		add: activityA.
	model
		add: participantB;
		add: activityB;
		add: communication.
	activityA send: communication.
	activityB receive: communication.
	^ model
]

{ #category : 'tests' }
BormCommunicationSimulationTest >> testCommunicationStepSimulation [

	| activitySimulatorA activitySimulatorB |
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	self assert: activitySimulatorA tokenCount equals: 1.
	self assert: activitySimulatorB tokenCount equals: 0.
	simulator step.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 1
]
