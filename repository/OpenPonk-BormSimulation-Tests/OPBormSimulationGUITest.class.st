"
Headless tests for the BORM simulation GUI presenter, constraint configuration menu, and simulation model command. Verifies deterministic diagram coloring, hidden element safety, dynamic and preset constraint controls, and window lifecycle cleanup.
"
Class {
	#name : 'OPBormSimulationGUITest',
	#superclass : 'OPAbstractUITest',
	#instVars : [
		'openWindowsBefore',
		'model',
		'editor',
		'diagramController',
		'simulationGui',
		'constraintA',
		'constraintB',
		'dataFlow'
	],
	#category : 'OpenPonk-BormSimulation-Tests-Simulation',
	#package : 'OpenPonk-BormSimulation-Tests',
	#tag : 'Simulation'
}

{ #category : 'running' }
OPBormSimulationGUITest >> buildBormModel [

	| participantA participantB communication |
	model := BormORModel named: 'Simulation BORM'.
	participantA := self buildParticipantA.
	participantB := self buildParticipantB.
	model addAll: {
			participantA.
			participantB }.
	communication := BormFactory communicationFrom: participantA @ 'ActivityA' to: participantB @ 'ActivityB'.
	dataFlow := BormDataFlow named: 'Payload'.
	communication addDataFlow: dataFlow
]

{ #category : 'running' }
OPBormSimulationGUITest >> buildParticipantA [

	| participant stateStart activityA stateWaiting stateEnd stateAltEnd transitionToActivityA transitionToWaiting transitionToEnd transitionToAltEnd |
	participant := BormParticipant named: 'ParticipantA'.
	stateStart := (BormState named: 'Start')
		              beInitial;
		              yourself.
	activityA := BormActivity named: 'ActivityA'.
	stateWaiting := BormState named: 'Waiting'.
	stateEnd := (BormState named: 'End')
		            beFinal;
		            yourself.
	stateAltEnd := (BormState named: 'AltEnd')
		               beFinal;
		               yourself.
	transitionToActivityA := BormTransition from: stateStart to: activityA.
	transitionToWaiting := BormTransition from: activityA to: stateWaiting.
	transitionToEnd := BormTransition from: stateWaiting to: stateEnd.
	transitionToAltEnd := BormTransition from: stateWaiting to: stateAltEnd.
	constraintA := BormConstraint named: 'ConstraintA'.
	constraintB := BormConstraint named: 'ConstraintB'.
	transitionToEnd constraint: constraintA.
	transitionToAltEnd constraint: constraintB.
	participant addAll: {
			stateStart.
			activityA.
			stateWaiting.
			stateEnd.
			stateAltEnd.
			transitionToActivityA.
			transitionToWaiting.
			transitionToEnd.
			transitionToAltEnd }.
	^ participant
]

{ #category : 'running' }
OPBormSimulationGUITest >> buildParticipantB [

	| participant activityB stateBEnd transitionBEnd |
	participant := BormParticipant named: 'ParticipantB'.
	activityB := BormActivity named: 'ActivityB'.
	stateBEnd := (BormState named: 'BEnd')
		             beFinal;
		             yourself.
	transitionBEnd := BormTransition from: activityB to: stateBEnd.
	participant addAll: {
			activityB.
			stateBEnd.
			transitionBEnd }.
	^ participant
]

{ #category : 'running' }
OPBormSimulationGUITest >> setUp [

	| project diagram projectController plugin |
	super setUp.
	openWindowsBefore := (self currentWorld submorphs select: [ :eachMorph | eachMorph isSystemWindow ]) asIdentitySet.
	self buildBormModel.
	project := OPProject named: 'BORM Simulation Test'.
	project addModel: model.
	diagram := OPOpenPonkDiagram forModelElement: model.
	project addDiagram: diagram.
	projectController := OPProjectController forProject: project.
	plugin := OPPluginRegistry default plugins detect: [ :eachPlugin | eachPlugin isKindOf: OPBormPlugin ].
	editor := OPEditor on: plugin.
	diagramController := OPBormDiagramController new.
	projectController addDiagramController: diagramController.
	diagramController
		editor: editor;
		canvasPresenter: (OPCanvasPresenter new
				 canvas: RSCanvas new;
				 yourself);
		diagramElement: diagram;
		model: model
]

{ #category : 'running' }
OPBormSimulationGUITest >> tearDown [

	(simulationGui isNotNil and: [ simulationGui isOpen ]) ifTrue: [ simulationGui close ].
	OPSimulationRegistry default closeAll.
	self currentWorld submorphs
		select: [ :eachMorph | eachMorph isSystemWindow and: [ (openWindowsBefore includes: eachMorph) not ] ]
		thenDo: [ :eachWindow | eachWindow delete ].
	simulationGui := nil.
	diagramController := nil.
	editor := nil.
	constraintA := nil.
	constraintB := nil.
	dataFlow := nil.
	model := nil.
	openWindowsBefore := nil.
	super tearDown
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testButtonItemsAndDeterministicActions [

	| buttonsByLabel startSimulator activityASimulator playPauseButton stepAllButton |
	diagramController showAllElements.
	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	simulationGui session uiDispatcher: [ :aBlock | aBlock value ].
	self assert: simulationGui simulatorClass identicalTo: OPBormSimulator.
	self assert: simulationGui hasConfiguration description: 'BORM simulation GUI must declare configuration sidebar support'.
	self assert: (simulationGui buttons collect: #label as: Array) equals: #( 'Play' 'Step all' 'Reset' 'Constraints' ).

	buttonsByLabel := (simulationGui buttons collect: [ :eachButton | eachButton label -> eachButton ]) asDictionary.
	startSimulator := simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::Start'.
	activityASimulator := simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::ActivityA'.

	self assert: startSimulator tokenCount equals: 1.
	self assert: activityASimulator tokenCount equals: 0.

	stepAllButton := buttonsByLabel at: 'Step all'.
	stepAllButton performAction.
	self assert: startSimulator tokenCount equals: 0.
	self assert: activityASimulator tokenCount equals: 1.

	(buttonsByLabel at: 'Reset') performAction.
	self assert: startSimulator tokenCount equals: 1.
	self assert: activityASimulator tokenCount equals: 0.

	playPauseButton := buttonsByLabel at: 'Play'.
	simulationGui session delay: 5000.
	playPauseButton performAction.
	self assert: simulationGui session isRunning description: 'Clicking Play must start running simulation'.
	self assert: playPauseButton label equals: 'Pause'.
	self deny: stepAllButton isEnabled description: 'Step all button must be disabled while running'.

	playPauseButton performAction.
	self deny: simulationGui session isRunning description: 'Clicking Pause must stop simulation'.
	self assert: playPauseButton label equals: 'Play'.
	self assert: stepAllButton isEnabled description: 'Step all button must re-enable after pausing'
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testClosedAndUnopenedGuiActionsAndVisualUpdatesAreSafe [

	| unopenedGui |
	unopenedGui := OPBormSimulationGUI new.
	unopenedGui stepAll.
	unopenedGui updateSimulationVisuals.
	unopenedGui handleSimulatorStepped: (OPSimulatorStepped simulator: nil transfers: #(  )).
	self deny: unopenedGui isOpen description: 'Unopened BORM simulation GUI must remain closed after no-op actions'.
	self
		deny: unopenedGui isConfigurationVisible
		description: 'No-op actions on unopened BORM simulation GUI must not open configuration sidebar'
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testConstraintsSidebarTogglesDisplaysEmptyStateAndUpdatesLiveHighlights [

	| constraintsButton waitingController checkboxes emptyModel emptyProject emptyDiagram emptyProjectController emptyController emptyGui |
	diagramController showAllElements.
	waitingController := diagramController controllerForModel: model @ 'ParticipantA::Waiting'.
	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	self deny: simulationGui isConfigurationVisible description: 'Constraints sidebar must start collapsed'.
	self assert: simulationGui layout class identicalTo: SpBoxLayout.

	constraintsButton := simulationGui buttons detect: [ :eachButton | eachButton label = 'Constraints' ].
	constraintsButton performAction.
	self assert: simulationGui isConfigurationVisible description: 'Clicking Constraints must open right sidebar'.
	self assert: simulationGui layout class identicalTo: SpPanedLayout.
	self assert: simulationGui configurationPresenter class identicalTo: OPBormConstraintMenuGUI.

	checkboxes := simulationGui configurationPresenter constraintCheckboxes.
	self assert: (checkboxes collect: #label as: Array) equals: #( 'ConstraintA -> End' 'ConstraintB -> AltEnd' ).

	simulationGui diagramSimulator
		step;
		step.
	self assert: waitingController roassalShape color equals: Color lightOrange lighter.

	checkboxes do: [ :eachCheckbox | eachCheckbox state: true ].
	self assert: waitingController roassalShape color equals: Color green.

	constraintsButton performAction.
	self deny: simulationGui isConfigurationVisible description: 'Clicking Constraints again must collapse sidebar'.

	emptyModel := OPBormExamples exampleDataFlows.
	emptyProject := OPProject named: 'Empty Constraints Test'.
	emptyProject addModel: emptyModel.
	emptyDiagram := OPOpenPonkDiagram forModelElement: emptyModel.
	emptyProject addDiagram: emptyDiagram.
	emptyProjectController := OPProjectController forProject: emptyProject.
	emptyController := OPBormDiagramController new.
	emptyProjectController addDiagramController: emptyController.
	emptyController
		editor: editor;
		canvasPresenter: (OPCanvasPresenter new
				 canvas: RSCanvas new;
				 yourself);
		diagramElement: emptyDiagram;
		model: emptyModel.
	emptyGui := OPBormSimulationGUI diagramController: emptyController.
	[
		emptyGui showConfiguration.
		self assert: emptyGui isConfigurationVisible description: 'Sidebar must open cleanly even when diagram has no constraints'.
		self
			deny: emptyGui configurationPresenter hasConfigurableItems
			description: 'Constraint-free diagram must show empty state in sidebar' ] ensure: [ emptyGui close ]
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testLoanApprovalExampleSimulatesSingleChosenBranchWithAnyCondition [

	| loanModel loanSimulator approvedSimulator rejectedSimulator |
	loanModel := OPBormExamples exampleLoanApproval.
	self
		assert: (loanModel @ 'Applicant::waiting for decision') outputSimulationCondition class
		identicalTo: BormNodeAnyNeighborSimulationCondition.

	loanSimulator := OPBormSimulator model: loanModel.
	approvedSimulator := loanSimulator elements detect: [ :each |
		                     (each isKindOf: OPBormConstraintSimulator) and: [ each model name = 'approved' ] ].
	rejectedSimulator := loanSimulator elements detect: [ :each |
		                     (each isKindOf: OPBormConstraintSimulator) and: [ each model name = 'rejected' ] ].
	approvedSimulator value: true.
	rejectedSimulator value: false.

	6 timesRepeat: [ loanSimulator step ].
	self assert: (loanSimulator simulatorOf: loanModel @ 'Applicant::loan active') tokenCount equals: 1.
	self assert: (loanSimulator simulatorOf: loanModel @ 'Applicant::loan rejected') tokenCount equals: 0
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testSimulationCommandActivationAndExecution [

	| activation toolContext command |
	activation := OPBormSimulationCommand modelMenuActivation.
	self assert: activation class identicalTo: OPModelMenuActivation.

	diagramController showAllElements.
	editor instVarNamed: #diagramController put: diagramController.
	toolContext := CmdSimpleToolContext for: editor.
	command := OPBormSimulationCommand new.
	self assert: command defaultMenuItemName equals: 'Simulation'.
	self assert: command defaultMenuIconName equals: #glamorousSpawn.
	command
		readParametersFromContext: toolContext;
		prepareFullExecutionInContext: toolContext;
		execute.

	simulationGui := OPBormSimulationGUI allInstances
		                 detect: [ :eachGui | eachGui isOpen and: [ eachGui diagramController == diagramController ] ]
		                 ifNone: [ self fail: 'Executing OPBormSimulationCommand must open OPBormSimulationGUI' ].
	self assert: simulationGui diagramModel identicalTo: model
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testStepAllOpensSidebarWhenInitiallyBlockedByConstraints [

	| blockedModel participant startState endState constrainedTransition gateConstraint project diagram projectController blockedController stepAllButton |
	blockedModel := BormORModel named: 'Initially Blocked'.
	participant := BormParticipant named: 'Actor'.
	startState := (BormState named: 'Start')
		              beInitial;
		              yourself.
	endState := (BormState named: 'End')
		            beFinal;
		            yourself.
	constrainedTransition := BormTransition from: startState to: endState.
	gateConstraint := BormConstraint named: 'Gate'.
	constrainedTransition constraint: gateConstraint.
	blockedModel add: participant.
	participant addAll: {
			startState.
			endState.
			constrainedTransition }.

	project := OPProject named: 'Initially Blocked Test'.
	project addModel: blockedModel.
	diagram := OPOpenPonkDiagram forModelElement: blockedModel.
	project addDiagram: diagram.
	projectController := OPProjectController forProject: project.
	blockedController := OPBormDiagramController new.
	projectController addDiagramController: blockedController.
	blockedController
		editor: editor;
		canvasPresenter: (OPCanvasPresenter new
				 canvas: RSCanvas new;
				 yourself);
		diagramElement: diagram;
		model: blockedModel.
	blockedController showAllElements.

	simulationGui := OPBormSimulationGUI diagramController: blockedController.
	self deny: simulationGui isConfigurationVisible description: 'Sidebar must start collapsed even when initial state is blocked'.
	self deny: simulationGui diagramSimulator isSteppable description: 'Initially blocked simulator must not be steppable'.

	stepAllButton := simulationGui buttons detect: [ :eachButton | eachButton label = 'Step all' ].
	stepAllButton performAction.
	self
		assert: simulationGui isConfigurationVisible
		description: 'Clicking Step all while blocked at step 0 must open constraints sidebar'.
	self
		assert: (simulationGui configurationPresenter groupHeaderLabels collect: #label as: Array)
		equals: #( 'Start (Actor) [waiting]' ).
	self assert: (simulationGui configurationPresenter constraintCheckboxes collect: #label as: Array) equals: #( 'Gate -> End' ).

	simulationGui configurationPresenter constraintCheckboxes first state: true.
	stepAllButton performAction.
	self assert: (simulationGui diagramSimulator simulatorOf: startState) tokenCount equals: 0.
	self assert: (simulationGui diagramSimulator simulatorOf: endState) tokenCount equals: 1
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testStepRecordsTransitionsAndCommunicationsExcludingBlockedConstraints [

	| steppedEvents startNode activityA waitingNode endNode altEndNode activityB bEndNode toActivityA toWaiting toEnd commAB toBEnd constraintASim |
	waitingNode := model @ 'ParticipantA::Waiting'.
	waitingNode outputSimulationCondition: BormNodeAnyNeighborSimulationCondition new.
	diagramController showAllElements.
	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	steppedEvents := OrderedCollection new.
	simulationGui diagramSimulator when: OPSimulatorStepped do: [ :event | steppedEvents add: event ] for: self.

	startNode := model @ 'ParticipantA::Start'.
	activityA := model @ 'ParticipantA::ActivityA'.
	endNode := model @ 'ParticipantA::End'.
	altEndNode := model @ 'ParticipantA::AltEnd'.
	activityB := model @ 'ParticipantB::ActivityB'.
	bEndNode := model @ 'ParticipantB::BEnd'.
	toActivityA := (simulationGui diagramSimulator simulatorOf: startNode) outgoing first model.
	toWaiting := ((simulationGui diagramSimulator simulatorOf: activityA) outgoing detect: [ :each |
		              each target model == waitingNode ]) model.
	commAB := ((simulationGui diagramSimulator simulatorOf: activityA) outgoing detect: [ :each | each target model == activityB ])
		          model.
	toEnd := ((simulationGui diagramSimulator simulatorOf: waitingNode) outgoing detect: [ :each | each target model == endNode ])
		         model.
	toBEnd := (simulationGui diagramSimulator simulatorOf: activityB) outgoing first model.

	simulationGui session step.
	self
		assert: steppedEvents first transfers
		equals: { (OPSimulationTransfer source: startNode edge: toActivityA target: activityA) }.

	simulationGui session step.
	self assertCollection: steppedEvents second transfers hasSameElements: {
			(OPSimulationTransfer source: activityA edge: toWaiting target: waitingNode).
			((OPSimulationTransfer source: activityA edge: commAB target: activityB)
				 kind: #message;
				 yourself) }.

	constraintASim := simulationGui diagramSimulator simulatorOf: constraintA.
	constraintASim value: true.
	simulationGui session step.
	self assertCollection: steppedEvents third transfers hasSameElements: {
			(OPSimulationTransfer source: waitingNode edge: toEnd target: endNode).
			(OPSimulationTransfer source: activityB edge: toBEnd target: bEndNode) }.
	self
		deny: (steppedEvents third transfers anySatisfy: [ :each | each targetModel == altEndNode ])
		description: 'Blocked branch with unmet constraint must not emit a transfer'
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testUnmetConstraintPausesPlaybackOpensSidebarAndAllowsContinuing [

	| checkboxes waitingSimulator endSimulator altEndSimulator bEndSimulator stepAllButton resetButton stoppedSemaphore |
	diagramController showAllElements.
	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	simulationGui session uiDispatcher: [ :aBlock | aBlock value ].
	waitingSimulator := simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::Waiting'.
	endSimulator := simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::End'.
	altEndSimulator := simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::AltEnd'.
	bEndSimulator := simulationGui diagramSimulator simulatorOf: model @ 'ParticipantB::BEnd'.
	stepAllButton := simulationGui buttons detect: [ :eachButton | eachButton label = 'Step all' ].
	resetButton := simulationGui buttons detect: [ :eachButton | eachButton label = 'Reset' ].

	stoppedSemaphore := Semaphore new.
	simulationGui diagramSimulator
		delay: 1;
		when: OPSimulatorStoppedRun do: [ stoppedSemaphore signal ] for: self.
	simulationGui session play.
	self
		deny: (stoppedSemaphore waitTimeoutSeconds: 3)
		description: 'Encountering an unmet constraint during Play must pause playback'.
	self deny: simulationGui session isRunning description: 'Session must be paused when unmet constraint is encountered'.
	self assert: simulationGui isConfigurationVisible description: 'Encountering unmet constraint must open configuration sidebar'.
	self assert: waitingSimulator tokenCount equals: 1.
	self
		assert: (simulationGui configurationPresenter groupHeaderLabels collect: #label as: Array)
		equals: #( 'Waiting (ParticipantA) [waiting]' ).

	stepAllButton performAction.
	self assert: bEndSimulator tokenCount equals: 1.
	self assert: waitingSimulator tokenCount equals: 1.

	checkboxes := simulationGui configurationPresenter constraintCheckboxes.
	checkboxes do: [ :eachCheckbox | eachCheckbox state: true ].
	stepAllButton performAction.
	self assert: waitingSimulator tokenCount equals: 0.
	self assert: endSimulator tokenCount equals: 1.
	self assert: altEndSimulator tokenCount equals: 1.

	resetButton performAction.
	self assert: (simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::Start') tokenCount equals: 1.
	self
		assert: (simulationGui diagramSimulator simulatorOf: constraintA) value
		description: 'Reset must preserve manual constraint values'.

	checkboxes first state: false.
	simulationGui hideConfiguration.
	stepAllButton performAction.
	stepAllButton performAction.
	self
		assert: simulationGui isConfigurationVisible
		description: 'After Reset, hitting an unmet constraint must reopen configuration sidebar'
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testUpdateDataFlowColorsDoesNotHighlightTargetWithoutDataFlows [

	| communication activityBController |
	communication := (model @ 'ParticipantA::ActivityA') communications first.
	communication remove: dataFlow.
	diagramController showAllElements.
	activityBController := diagramController controllerForModel: model @ 'ParticipantB::ActivityB'.

	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	simulationGui diagramSimulator step.

	self assert: activityBController roassalShape color equals: activityBController diagramElement defaultBackgroundColor
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testUpdateSimulationVisualsIgnoresHiddenAndUnrenderedElements [

	| activityAController dataFlowController |
	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	simulationGui diagramSimulator step.
	self assert: (simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::ActivityA') tokenCount equals: 1.

	diagramController showAllElements.
	activityAController := diagramController controllerForModel: model @ 'ParticipantA::ActivityA'.
	dataFlowController := diagramController controllerForModel: dataFlow.
	activityAController removeRender.
	dataFlowController removeRender.

	simulationGui updateSimulationVisuals.
	self assert: activityAController roassalShape identicalTo: nil.
	self assert: dataFlowController roassalShape identicalTo: nil
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testUpdateSimulationVisualsPreservesCustomColorsAndRestoresOnResetReloadAndClose [

	| startController activityAController waitingController endController altEndController activityBController bEndController dataFlowController customStartColor customDataFlowColor |
	diagramController showAllElements.
	startController := diagramController controllerForModel: model @ 'ParticipantA::Start'.
	activityAController := diagramController controllerForModel: model @ 'ParticipantA::ActivityA'.
	waitingController := diagramController controllerForModel: model @ 'ParticipantA::Waiting'.
	endController := diagramController controllerForModel: model @ 'ParticipantA::End'.
	altEndController := diagramController controllerForModel: model @ 'ParticipantA::AltEnd'.
	activityBController := diagramController controllerForModel: model @ 'ParticipantB::ActivityB'.
	bEndController := diagramController controllerForModel: model @ 'ParticipantB::BEnd'.
	dataFlowController := diagramController controllerForModel: dataFlow.

	customStartColor := Color cyan.
	customDataFlowColor := Color veryLightGray.
	startController roassalShape color: customStartColor.
	dataFlowController roassalShape color: customDataFlowColor.

	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	self assert: startController roassalShape color equals: Color green.
	self assert: activityAController roassalShape color equals: activityAController diagramElement defaultBackgroundColor.
	self assert: dataFlowController roassalShape color equals: customDataFlowColor.

	simulationGui diagramSimulator step.
	self assert: startController roassalShape color equals: customStartColor.
	self assert: activityAController roassalShape color equals: Color green.
	self assert: dataFlowController roassalShape color equals: Color yellow.
	self assert: activityBController roassalShape color equals: Color yellow.

	simulationGui diagramSimulator step.
	self assert: dataFlowController roassalShape color equals: customDataFlowColor.
	self assert: waitingController roassalShape color equals: Color lightOrange lighter.
	self assert: activityBController roassalShape color equals: Color green.

	(simulationGui diagramSimulator simulatorOf: constraintA) value: true.
	(simulationGui diagramSimulator simulatorOf: constraintB) value: true.
	simulationGui diagramSimulator step.
	self assert: endController roassalShape color equals: Color pink.
	self assert: altEndController roassalShape color equals: Color pink.
	self assert: bEndController roassalShape color equals: Color pink.

	simulationGui session reset.
	self assert: endController roassalShape color equals: endController diagramElement defaultBackgroundColor.
	self assert: startController roassalShape color equals: Color green.

	simulationGui reloadController.
	self assert: startController roassalShape color equals: Color green.
	self assert: dataFlowController roassalShape color equals: customDataFlowColor.

	simulationGui close.
	self assert: startController roassalShape color equals: customStartColor.
	self assert: dataFlowController roassalShape color equals: customDataFlowColor
]
