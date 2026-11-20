"
Unit tests for OPBormCommunicationSimulator.
Verifies token transfer logic and interactions between activities or states of different participants.
"
Class {
	#name : 'BormCommunicationSimulationTest',
	#superclass : 'BormSimulationTest',
	#instVars : [
		'participantA',
		'participantB',
		'activityA',
		'activityB',
		'communication'
	],
	#category : 'OpenPonk-BormSimulation-Tests-Simulation',
	#package : 'OpenPonk-BormSimulation-Tests',
	#tag : 'Simulation'
}

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

{ #category : 'running' }
BormCommunicationSimulationTest >> simulatorClass [

	^ OPBormSimulator
]

{ #category : 'tests' }
BormCommunicationSimulationTest >> testCommunicationAndDataFlowSimulatorsAreNotSimulableOrSteppable [

	| dataFlow localSimulator communicationSimulator dataFlowSimulator |
	dataFlow := self emptyDataFlow.
	communication addDataFlow: dataFlow.
	localSimulator := self simulatorClass model: model.
	communicationSimulator := localSimulator simulatorOf: communication.
	dataFlowSimulator := localSimulator simulatorOf: dataFlow.
	self deny: communicationSimulator isSimulable description: 'Communication simulator must not be simulable'.
	self deny: communicationSimulator isSteppable description: 'Communication simulator must not be steppable'.
	self deny: dataFlowSimulator isSimulable description: 'Data flow simulator must not be simulable'
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
