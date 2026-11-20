"
Unit tests for OPBormStateSimulator.
Verifies the token lifecycle and proper transition stepping originating from a BORM state.
"
Class {
	#name : 'BormStateSimulationTest',
	#superclass : 'BormSimulationTest',
	#instVars : [
		'stateA',
		'participantA'
	],
	#category : 'OpenPonk-BormSimulation-Tests-Simulation',
	#package : 'OpenPonk-BormSimulation-Tests',
	#tag : 'Simulation'
}

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

{ #category : 'running' }
BormStateSimulationTest >> simulatorClass [

	^ OPBormSimulator
]

{ #category : 'tests' }
BormStateSimulationTest >> testInitialStateWithIncomingTransitionReceivesInitialToken [

	| loopModel participant initialState secondState forwardTransition backwardTransition loopSimulator |
	loopModel := self emptyModel.
	participant := self emptyParticipant.
	initialState := self emptyState
		                beInitial;
		                yourself.
	secondState := self emptyState.
	forwardTransition := self emptyTransition.
	backwardTransition := self emptyTransition.
	forwardTransition from: initialState to: secondState.
	backwardTransition from: secondState to: initialState.
	loopModel add: participant.
	participant addAll: {
			initialState.
			secondState.
			forwardTransition.
			backwardTransition }.
	loopSimulator := self simulatorClass model: loopModel.
	self assert: (loopSimulator simulatorOf: initialState) tokenCount equals: 1.
	self assert: (loopSimulator simulatorOf: secondState) tokenCount equals: 0
]

{ #category : 'tests' }
BormStateSimulationTest >> testPrintOnIncludesTokenCount [

	| stateSimulatorA |
	stateSimulatorA := simulator simulatorOf: stateA.
	self
		assert: (stateSimulatorA printString endsWith: '(1)')
		description: 'Element simulator printString must include its token count'
]

{ #category : 'tests' }
BormStateSimulationTest >> testTokenIsNeitherSimulableNorSteppable [

	| token |
	token := OPBormToken new.
	self assert: token type equals: 'OPBormTransitionSimulator'.
	self deny: token isSimulable description: 'BORM token must not be simulable'.
	self deny: token isSteppable description: 'BORM token must not be steppable'
]

{ #category : 'tests' }
BormStateSimulationTest >> testTransitionStepSimulation [

	| stateSimulatorA |
	stateSimulatorA := simulator simulatorOf: stateA.
	self assert: stateSimulatorA tokenCount equals: 1
]
