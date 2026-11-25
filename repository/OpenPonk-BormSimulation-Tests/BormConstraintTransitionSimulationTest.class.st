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
	#category : 'OpenPonk-BormSimulation-Tests-Simulation',
	#package : 'OpenPonk-BormSimulation-Tests',
	#tag : 'Simulation'
}

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

{ #category : 'running' }
BormConstraintTransitionSimulationTest >> simulatorClass [

	^ OPBormSimulator
]

{ #category : 'tests' }
BormConstraintTransitionSimulationTest >> testBlockedByConstraintsRespectsOutputConditionModesAndFinalNodes [

	| stateSimulatorA stateSimulatorB constraintSimulator |
	stateSimulatorA := simulator simulatorOf: stateA.
	stateSimulatorB := simulator simulatorOf: stateB.
	constraintSimulator := simulator simulatorOf: constraint.

	self assert: stateSimulatorA isBlockedByConstraints description: 'Node with token and unmet All constraint must report blocked'.
	self assertCollection: simulator blockedByConstraintElements hasSameElements: { stateSimulatorA }.
	self deny: stateSimulatorB isBlockedByConstraints description: 'Node without tokens must not report blocked'.

	stateA outputSimulationCondition: BormNodeAnyNeighborSimulationCondition new.
	self
		assert: stateSimulatorA isBlockedByConstraints
		description: 'Node with token and all Any constraints unmet must report blocked'.

	stateA outputSimulationCondition: BormNodeNoneNeighborSimulationCondition new.
	self
		deny: stateSimulatorA isBlockedByConstraints
		description: 'Node with None output condition must not report blocked by constraints'.

	stateA outputSimulationCondition: BormNodeAllNeighborSimulationCondition new.
	constraintSimulator value: true.
	self deny: stateSimulatorA isBlockedByConstraints description: 'Node with satisfied constraints must not report blocked'.
	self assertEmpty: simulator blockedByConstraintElements.

	simulator step.
	self deny: stateSimulatorB isBlockedByConstraints description: 'Final node without outgoing edges must not report blocked'
]

{ #category : 'tests' }
BormConstraintTransitionSimulationTest >> testResetPreservesManualConstraintValuesAndRestoresTokens [

	| stateSimulatorA stateSimulatorB constraintSimulator |
	stateSimulatorA := simulator simulatorOf: stateA.
	stateSimulatorB := simulator simulatorOf: stateB.
	constraintSimulator := simulator simulatorOf: constraint.
	constraintSimulator value: true.

	simulator step.
	self assert: stateSimulatorA tokenCount equals: 0.
	self assert: stateSimulatorB tokenCount equals: 1.

	simulator reset.
	self assert: stateSimulatorA tokenCount equals: 1.
	self assert: stateSimulatorB tokenCount equals: 0.
	self assert: constraintSimulator value description: 'Reset must preserve manually configured constraint values'
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
