"
Unit tests verifying the evaluation of complex output conditions (e.g., ALL, ANY, NONE) for BORM elements during simulation.
"
Class {
	#name : 'BormOutputConditionsSimulationTest',
	#superclass : 'BormSimulationTest',
	#instVars : [
		'participantA',
		'state',
		'activityA',
		'activityB',
		'transitionA',
		'transitionB',
		'constraintA',
		'constraintB'
	],
	#category : 'OpenPonk-BormSimulation-Tests-Simulation',
	#package : 'OpenPonk-BormSimulation-Tests',
	#tag : 'Simulation'
}

{ #category : 'running' }
BormOutputConditionsSimulationTest >> exampleModel [

	model := self emptyModel.
	participantA := self emptyParticipant.
	state := self emptyState.
	activityA := self emptyActivity.
	activityB := self emptyActivity.
	transitionA := self emptyTransition.
	transitionB := self emptyTransition.
	constraintA := self emptyConstraint.
	constraintB := self emptyConstraint.
	transitionA from: state to: activityA.
	transitionB from: state to: activityB.
	model
		add: participantA;
		add: state;
		add: transitionA;
		add: constraintA.
	participantA add: activityA.
	participantA add: activityB.
	state
		add: transitionB;
		add: constraintB.

	transitionA constraint: constraintA.
	transitionB constraint: constraintB.

	^ model
]

{ #category : 'running' }
BormOutputConditionsSimulationTest >> simulatorClass [

	^ OPBormSimulator
]

{ #category : 'tests' }
BormOutputConditionsSimulationTest >> testConstraintStepAllSimulationFalse [

	| stateSimulator activitySimulatorB activitySimulatorA constraintSimulatorA constraintSimulatorB |
	state outputSimulationCondition: BormNodeAllNeighborSimulationCondition new.
	stateSimulator := simulator simulatorOf: state.
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	constraintSimulatorA := simulator simulatorOf: constraintA.
	constraintSimulatorB := simulator simulatorOf: constraintB.
	constraintSimulatorA value: false.
	constraintSimulatorB value: true.
	self assert: stateSimulator tokenCount equals: 1.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 0.
	simulator step.
	self assert: stateSimulator tokenCount equals: 1.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 0
]

{ #category : 'tests' }
BormOutputConditionsSimulationTest >> testConstraintStepAllSimulationTrue [

	| stateSimulator activitySimulatorB activitySimulatorA constraintSimulatorA constraintSimulatorB |
	state outputSimulationCondition: BormNodeAllNeighborSimulationCondition new.
	stateSimulator := simulator simulatorOf: state.
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	constraintSimulatorA := simulator simulatorOf: constraintA.
	constraintSimulatorB := simulator simulatorOf: constraintB.
	constraintSimulatorA value: true.
	constraintSimulatorB value: true.
	self assert: stateSimulator tokenCount equals: 1.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 0.
	simulator step.
	self assert: stateSimulator tokenCount equals: 0.
	self assert: activitySimulatorA tokenCount equals: 1.
	self assert: activitySimulatorB tokenCount equals: 1
]

{ #category : 'tests' }
BormOutputConditionsSimulationTest >> testConstraintStepAnySimulationFalse [

	| stateSimulator activitySimulatorA activitySimulatorB constraintSimulatorA constraintSimulatorB |
	state outputSimulationCondition: BormNodeAnyNeighborSimulationCondition new.
	stateSimulator := simulator simulatorOf: state.
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	constraintSimulatorA := simulator simulatorOf: constraintA.
	constraintSimulatorB := simulator simulatorOf: constraintB.
	constraintSimulatorA value: false.
	constraintSimulatorB value: false.
	simulator step.
	self assert: stateSimulator tokenCount equals: 1.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 0
]

{ #category : 'tests' }
BormOutputConditionsSimulationTest >> testConstraintStepAnySimulationTrue [

	| stateSimulator activitySimulatorB activitySimulatorA constraintSimulatorA constraintSimulatorB |
	state outputSimulationCondition: BormNodeAnyNeighborSimulationCondition new.
	stateSimulator := simulator simulatorOf: state.
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	constraintSimulatorA := simulator simulatorOf: constraintA.
	constraintSimulatorB := simulator simulatorOf: constraintB.
	constraintSimulatorA value: false.
	constraintSimulatorB value: true.
	self assert: stateSimulator tokenCount equals: 1.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 0.
	simulator step.
	self assert: stateSimulator tokenCount equals: 0.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 1
]

{ #category : 'tests' }
BormOutputConditionsSimulationTest >> testConstraintStepAnySimulationWithUnconstrainedEdge [

	| stateSimulator activitySimulatorA activitySimulatorB constraintSimulatorB |
	state outputSimulationCondition: BormNodeAnyNeighborSimulationCondition new.
	transitionA constraint: nil.
	stateSimulator := simulator simulatorOf: state.
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	constraintSimulatorB := simulator simulatorOf: constraintB.
	constraintSimulatorB value: false.
	simulator step.
	self assert: stateSimulator tokenCount equals: 0.
	self assert: activitySimulatorA tokenCount equals: 1.
	self assert: activitySimulatorB tokenCount equals: 0
]

{ #category : 'tests' }
BormOutputConditionsSimulationTest >> testConstraintStepNoneSimulationTrue [

	| stateSimulator activitySimulatorB activitySimulatorA constraintSimulatorA constraintSimulatorB |
	state outputSimulationCondition: BormNodeNoneNeighborSimulationCondition new.
	stateSimulator := simulator simulatorOf: state.
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	constraintSimulatorA := simulator simulatorOf: constraintA.
	constraintSimulatorB := simulator simulatorOf: constraintB.
	constraintSimulatorA value: false.
	constraintSimulatorB value: true.
	self assert: stateSimulator tokenCount equals: 1.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 0.
	simulator step.
	self assert: stateSimulator tokenCount equals: 0.
	self assert: activitySimulatorA tokenCount equals: 1.
	self assert: activitySimulatorB tokenCount equals: 1
]

{ #category : 'tests' }
BormOutputConditionsSimulationTest >> testTransitionConstraintStepSimulationTrue [

	| stateSimulator activitySimulatorB activitySimulatorA constraintSimulatorA constraintSimulatorB |
	stateSimulator := simulator simulatorOf: state.
	activitySimulatorA := simulator simulatorOf: activityA.
	activitySimulatorB := simulator simulatorOf: activityB.
	constraintSimulatorA := simulator simulatorOf: constraintA.
	constraintSimulatorB := simulator simulatorOf: constraintB.
	constraintSimulatorA value: true.
	constraintSimulatorB value: true.
	self assert: stateSimulator tokenCount equals: 1.
	self assert: activitySimulatorA tokenCount equals: 0.
	self assert: activitySimulatorB tokenCount equals: 0.
	simulator step.
	self assert: stateSimulator tokenCount equals: 0.
	self assert: activitySimulatorA tokenCount equals: 1.
	self assert: activitySimulatorB tokenCount equals: 1
]
