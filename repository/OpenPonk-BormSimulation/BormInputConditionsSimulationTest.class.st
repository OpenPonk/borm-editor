Class {
	#name : 'BormInputConditionsSimulationTest',
	#superclass : 'BormSimulationTest',
	#instVars : [
		'participantA',
		'constraint',
		'participantB',
		'activityA',
		'activityB',
		'communication',
		'stateA',
		'stateB',
		'stateEnd',
		'transitionA',
		'transitionB',
		'transitionC',
		'constraintA',
		'constraintB',
		'stateC',
		'constraintC',
		'transitionD'
	],
	#category : 'OpenPonk-BormSimulation-Tests',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Tests'
}

{ #category : 'running' }
BormInputConditionsSimulationTest >> controllerClass [

	^ OPBormSimulator
]

{ #category : 'tests' }
BormInputConditionsSimulationTest >> endStateValueForGiven: constraintAValue b: constraintBValue c: constraintCValue numberOfSteps: numberOfSteps [

	| constraintSimulatorA constraintSimulatorB constraintSimulatorC endStateSimulator |
	endStateSimulator := simulator simulatorOf: stateEnd.
	constraintSimulatorA := simulator simulatorOf: constraintA.
	constraintSimulatorB := simulator simulatorOf: constraintB.
	constraintSimulatorC := simulator simulatorOf: constraintC.
	constraintSimulatorA value: constraintAValue.
	constraintSimulatorB value: constraintBValue.
	constraintSimulatorC value: constraintCValue.
	1 to: numberOfSteps do: [ :index | simulator step ].
	^ endStateSimulator tokenCount
]

{ #category : 'running' }
BormInputConditionsSimulationTest >> exampleModel [

	model := self emptyModel.
	participantA := self emptyParticipant.
	participantB := self emptyParticipant.
	stateA := self emptyState.
	stateB := self emptyState.
	stateC := self emptyState.
	stateEnd := self emptyState.
	activityA := self emptyActivity.
	activityB := self emptyActivity.
	communication := self emptyCommunication.
	transitionA := self emptyTransition.
	transitionB := self emptyTransition.
	transitionC := self emptyTransition.
	transitionD := self emptyTransition.
	constraintA := self emptyConstraint.
	constraintB := self emptyConstraint.
	constraintC := self emptyConstraint.
	communication from: activityA to: activityB.
	transitionA from: stateA to: activityA.
	transitionB from: stateB to: activityB.
	transitionC from: stateC to: activityA.
	transitionD from: activityA to: stateEnd.
	model
		add: participantA;
		add: stateA;
		add: transitionA.
	model
		add: participantB;
		add: stateB;
		add: transitionB.
	participantA
		add: stateC;
		add: transitionC.
	participantA add: stateEnd.
	participantA
		add: activityA;
		add: transitionD.
	participantB
		add: activityB;
		add: communication.

	transitionA constraint: constraintA.
	communication constraint: constraintB.
	transitionC constraint: constraintC.
	activityA receive: communication.
	activityB send: communication.


	^ model
]

{ #category : 'tests' }
BormInputConditionsSimulationTest >> testAllCommunicationFalse [

	activityA inputCommunicationSimulationCondition:
		BormNodeAllNeighborSimulationCondition new.
	self
		assert: (self
				 endStateValueForGiven: true
				 b: false
				 c: true
				 numberOfSteps: 3)
		equals: 0
]

{ #category : 'tests' }
BormInputConditionsSimulationTest >> testAllFalse [

	activityA inputTransitionSimulationCondition:
		BormNodeAllNeighborSimulationCondition new.
	self
		assert: (self
				 endStateValueForGiven: true
				 b: false
				 c: true
				 numberOfSteps: 3)
		equals: 0
]

{ #category : 'tests' }
BormInputConditionsSimulationTest >> testAllTwo [

	activityA inputTransitionSimulationCondition:
		BormNodeAllNeighborSimulationCondition new.
	self
		assert: (self
				 endStateValueForGiven: true
				 b: true
				 c: true
				 numberOfSteps: 3)
		equals: 1
]

{ #category : 'tests' }
BormInputConditionsSimulationTest >> testAnyOne [

	activityA inputTransitionSimulationCondition:
		BormNodeAnyNeighborSimulationCondition new.
	activityA inputCommunicationSimulationCondition:
		BormNodeNoneNeighborSimulationCondition new.
	self
		assert: (self
				 endStateValueForGiven: true
				 b: false
				 c: false
				 numberOfSteps: 2)
		equals: 1
]
