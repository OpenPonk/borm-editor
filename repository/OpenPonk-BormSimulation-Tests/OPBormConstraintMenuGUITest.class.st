"
Unit tests for OPBormConstraintMenuGUI verifying empty state, deterministic ordering, fallback labels, checkbox synchronization, and waiting-node header updates.
"
Class {
	#name : 'OPBormConstraintMenuGUITest',
	#superclass : 'TestCase',
	#instVars : [
		'configurationGui'
	],
	#category : 'OpenPonk-BormSimulation-Tests-Simulation',
	#package : 'OpenPonk-BormSimulation-Tests',
	#tag : 'Simulation'
}

{ #category : 'running' }
OPBormConstraintMenuGUITest >> tearDown [

	configurationGui := nil.
	super tearDown
]

{ #category : 'tests' }
OPBormConstraintMenuGUITest >> testCheckboxSyncsConstraintSimulatorInvokesCallbackAndRefreshesWaitingHeader [

	| model participant startState waitingState endState transitionToWaiting transitionToEnd constraint simulator changedSimulators checkbox |
	model := BormORModel named: 'Sync Test'.
	participant := BormParticipant named: 'Actor'.
	startState := (BormState named: 'Start')
		              beInitial;
		              yourself.
	waitingState := BormState named: 'Gate'.
	endState := (BormState named: 'Done')
		            beFinal;
		            yourself.
	transitionToWaiting := BormTransition from: startState to: waitingState.
	transitionToEnd := BormTransition from: waitingState to: endState.
	constraint := BormConstraint named: 'Ready'.
	transitionToEnd constraint: constraint.
	model add: participant.
	participant addAll: {
			startState.
			waitingState.
			endState.
			transitionToWaiting.
			transitionToEnd }.

	simulator := OPBormSimulator model: model.
	changedSimulators := OrderedCollection new.
	configurationGui := (OPBormConstraintMenuGUI on: simulator)
		                    onConstraintChanged: [ :constraintSimulator | changedSimulators add: constraintSimulator ];
		                    yourself.
	self assert: (configurationGui groupHeaderLabels collect: #label as: Array) equals: #( 'Gate (Actor)' ).

	simulator step.
	configurationGui refreshFromSimulator.
	self assert: (configurationGui groupHeaderLabels collect: #label as: Array) equals: #( 'Gate (Actor) [waiting]' ).

	checkbox := configurationGui constraintCheckboxes first.
	self deny: checkbox state description: 'Constraint checkbox must start unchecked'.
	checkbox state: true.
	self
		assert: (simulator simulatorOf: constraint) value
		description: 'Activating checkbox must set constraint simulator value to true'.
	self assertCollection: changedSimulators hasSameElements: { (simulator simulatorOf: constraint) }.

	configurationGui refreshFromSimulator.
	self assert: (configurationGui groupHeaderLabels collect: #label as: Array) equals: #( 'Gate (Actor)' ).

	changedSimulators removeAll.
	(simulator simulatorOf: constraint) value: false.
	configurationGui refreshFromSimulator.
	self deny: checkbox state description: 'refreshFromSimulator must synchronize checkbox state from simulator'.
	self assertEmpty: changedSimulators
]

{ #category : 'tests' }
OPBormConstraintMenuGUITest >> testDeterministicOrderingReadableLabelsAndUnnamedFallbacks [

	| loanSimulator customModel participantA participantB unnamedStateA unnamedStateB namedActivity receiverActivity unnamedTarget transitionA transitionB communication unnamedConstraintA unnamedConstraintB commConstraint |
	loanSimulator := OPBormSimulator model: OPBormExamples exampleLoanApproval.
	configurationGui := OPBormConstraintMenuGUI on: loanSimulator.
	self assert: configurationGui hasConfigurableItems description: 'Loan Approval example must have configurable constraints'.
	self assert: configurationGui descriptionLabel label equals: 'Checked conditions are satisfied during simulation.'.
	self assert: (configurationGui groupHeaderLabels collect: #label as: Array) equals: #( 'waiting for decision (Applicant)' ).
	self
		assert: (configurationGui constraintCheckboxes collect: #label as: Array)
		equals: #( 'approved -> signs loan contract' 'rejected -> reviews rejection reason' ).

	customModel := BormORModel named: 'Fallbacks'.
	participantA := BormParticipant named: 'SenderParticipant'.
	participantB := BormParticipant named: 'ReceiverParticipant'.
	unnamedStateA := BormState new.
	unnamedStateB := BormState new
		                 name: nil;
		                 yourself.
	namedActivity := BormActivity named: 'Dispatch'.
	unnamedTarget := BormActivity new.
	receiverActivity := BormActivity named: 'Receive'.
	transitionA := BormTransition from: unnamedStateA to: unnamedTarget.
	transitionB := BormTransition from: unnamedStateB to: namedActivity.
	unnamedConstraintA := BormConstraint named: '   '.
	unnamedConstraintB := BormConstraint new
		                      name: nil;
		                      yourself.
	transitionA constraint: unnamedConstraintA.
	transitionB constraint: unnamedConstraintB.
	customModel addAll: {
			participantA.
			participantB }.
	participantA addAll: {
			unnamedStateA.
			unnamedTarget.
			namedActivity.
			transitionA }.
	customModel addAll: {
			unnamedStateB.
			transitionB }.
	participantB add: receiverActivity.
	communication := BormFactory communicationFrom: namedActivity to: receiverActivity.
	commConstraint := BormConstraint named: 'Allowed'.
	communication constraint: commConstraint.

	configurationGui := OPBormConstraintMenuGUI on: (OPBormSimulator model: customModel).
	self assert: configurationGui groupHeaderLabels size equals: 3.
	self
		assert: (configurationGui groupHeaderLabels collect: #label as: Array)
		equals: #( '(unnamed state) [waiting]' '(unnamed state) (SenderParticipant) [waiting]'
		   'Dispatch (SenderParticipant)' ).
	self
		assert: (configurationGui constraintCheckboxes collect: #label as: Array)
		equals:
		#( '(unnamed constraint) -> Dispatch' '(unnamed constraint) -> (unnamed activity)' 'Allowed -> Receive (ReceiverParticipant)' )
]

{ #category : 'tests' }
OPBormConstraintMenuGUITest >> testInheritsSimulationConfigurationAndShowsEmptyStateForConstraintFreeExamples [

	self
		assert: (OPBormConstraintMenuGUI inheritsFrom: OPSimulationConfigurationGUI)
		description: 'OPBormConstraintMenuGUI must inherit from OPSimulationConfigurationGUI'.

	configurationGui := OPBormConstraintMenuGUI new.
	self deny: configurationGui hasConfigurableItems description: 'Presenter without simulator must have no configurable items'.
	self assert: configurationGui emptyStateMessage equals: 'No constraints in this diagram.'.

	#( exampleDataFlows examplePizzaDelivery exampleTravelingCard ) do: [ :eachSelector |
			| simulator |
			simulator := OPBormSimulator model: (OPBormExamples perform: eachSelector).
			configurationGui := OPBormConstraintMenuGUI on: simulator.
			self deny: configurationGui hasConfigurableItems description: 'Constraint-free example must not report configurable items'.
			self assert: configurationGui defaultLayout class identicalTo: SpBoxLayout.
			self assert: configurationGui defaultLayout children first label equals: 'No constraints in this diagram.' ]
]
