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
OPBormSimulationGUITest >> testAdjustWindowSizeWithoutOpenWindowIsSafe [

	| unopenedGui |
	unopenedGui := OPBormSimulationGUI new.
	unopenedGui adjustWindowSize.
	self deny: unopenedGui isOpen description: 'Unopened simulation GUI must remain closed'
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testButtonItemsAndDeterministicActions [

	| buttonItems buttonsByLabel startSimulator activityASimulator |
	diagramController showAllElements.
	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	self assert: simulationGui simulatorClass identicalTo: OPBormSimulator.

	buttonItems := simulationGui buttonItems.
	self assert: (buttonItems collect: #label as: Array) equals: #( 'Pause' 'Play' 'Step all' 'Set constraints' ).

	buttonsByLabel := (buttonItems collect: [ :eachButton | eachButton label -> eachButton ]) asDictionary.
	startSimulator := simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::Start'.
	activityASimulator := simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::ActivityA'.

	self assert: startSimulator tokenCount equals: 1.
	self assert: activityASimulator tokenCount equals: 0.

	(buttonsByLabel at: 'Step all') performAction.
	self assert: startSimulator tokenCount equals: 0.
	self assert: activityASimulator tokenCount equals: 1.

	(buttonsByLabel at: 'Pause') performAction.
	self
		deny: (simulationGui diagramSimulator instVarNamed: #shouldRun)
		description: 'Pause button must stop simulation running flag'
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testOpenConstraintMenuPresetsConstraintsAndSuppressesInlineMenu [

	| setConstraintsButton constraintMenu checkboxPairs constraintSimulatorA constraintSimulatorB |
	diagramController showAllElements.
	simulationGui := OPBormSimulationGUI diagramController: diagramController.

	setConstraintsButton := simulationGui buttonItems detect: [ :eachButton | eachButton label = 'Set constraints' ].
	setConstraintsButton performAction.

	constraintMenu := OPBormConstraintMenuGUI allInstances
		                  detect: [ :eachMenu | eachMenu isOpen ]
		                  ifNone: [ self fail: 'Clicking Set constraints must open OPBormConstraintMenuGUI' ].
	self assert: constraintMenu isOpen description: 'Constraint menu must report open while window is open'.
	self assert: constraintMenu window title equals: 'Constraint Menu'.

	checkboxPairs := constraintMenu instVarNamed: #checkboxes.
	self assert: checkboxPairs size equals: 2.

	constraintSimulatorA := simulationGui diagramSimulator simulatorOf: constraintA.
	constraintSimulatorB := simulationGui diagramSimulator simulatorOf: constraintB.
	checkboxPairs do: [ :eachPair | eachPair first state: true ].
	self assert: constraintSimulatorA value description: 'Activating checkbox must set constraint A to true'.
	self assert: constraintSimulatorB value description: 'Activating checkbox must set constraint B to true'.

	(checkboxPairs detect: [ :eachPair | eachPair second == constraintSimulatorA ]) first state: false.
	self deny: constraintSimulatorA value description: 'Deactivating checkbox must set constraint A back to false'.

	simulationGui diagramSimulator
		step;
		step.
	self assertEmpty: (simulationGui instVarNamed: #constraints).
	constraintMenu window close
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
OPBormSimulationGUITest >> testUpdateColorsHighlightsAllNodeStatesAndDataFlowsDeterministically [

	| startController activityAController waitingController endController altEndController activityBController bEndController dataFlowController |
	diagramController showAllElements.
	startController := diagramController controllerForModel: model @ 'ParticipantA::Start'.
	activityAController := diagramController controllerForModel: model @ 'ParticipantA::ActivityA'.
	waitingController := diagramController controllerForModel: model @ 'ParticipantA::Waiting'.
	endController := diagramController controllerForModel: model @ 'ParticipantA::End'.
	altEndController := diagramController controllerForModel: model @ 'ParticipantA::AltEnd'.
	activityBController := diagramController controllerForModel: model @ 'ParticipantB::ActivityB'.
	bEndController := diagramController controllerForModel: model @ 'ParticipantB::BEnd'.
	dataFlowController := diagramController controllerForModel: dataFlow.

	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	self assert: startController roassalShape color equals: Color green.
	self assert: activityAController roassalShape color equals: activityAController diagramElement defaultBackgroundColor.
	self assert: dataFlowController roassalShape color equals: Color transparent.

	simulationGui diagramSimulator step.
	self assert: startController roassalShape color equals: startController diagramElement defaultBackgroundColor.
	self assert: activityAController roassalShape color equals: Color green.
	self assert: dataFlowController roassalShape color equals: Color yellow.
	self assert: activityBController roassalShape color equals: Color yellow.

	simulationGui diagramSimulator step.
	self assert: dataFlowController roassalShape color equals: Color transparent.
	self assert: waitingController roassalShape color equals: Color lightOrange lighter.
	self assert: activityBController roassalShape color equals: Color green.

	(simulationGui diagramSimulator simulatorOf: constraintA) value: true.
	(simulationGui diagramSimulator simulatorOf: constraintB) value: true.
	simulationGui diagramSimulator step.
	self assert: endController roassalShape color equals: Color pink.
	self assert: altEndController roassalShape color equals: Color pink.
	self assert: bEndController roassalShape color equals: Color pink
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testUpdateColorsIgnoresHiddenAndUnrenderedElements [

	| activityAController dataFlowController |
	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	simulationGui diagramSimulator step.
	self assert: (simulationGui diagramSimulator simulatorOf: model @ 'ParticipantA::ActivityA') tokenCount equals: 1.

	diagramController showAllElements.
	activityAController := diagramController controllerForModel: model @ 'ParticipantA::ActivityA'.
	dataFlowController := diagramController controllerForModel: dataFlow.
	activityAController removeRender.
	dataFlowController removeRender.

	simulationGui updateColors.
	self assert: activityAController roassalShape identicalTo: nil.
	self assert: dataFlowController roassalShape identicalTo: nil
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testUpdateConstraintMenuAddsCheckboxesOnceAndSyncsValues [

	| initialExtent checkboxPairs constraintSimulatorA constraintSimulatorB layoutPresenters labels continueButtons |
	diagramController showAllElements.
	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	initialExtent := simulationGui window window extent.

	simulationGui diagramSimulator
		step;
		step.

	checkboxPairs := simulationGui instVarNamed: #checkboxes.
	self assert: checkboxPairs size equals: 2.
	self assert: (simulationGui instVarNamed: #usedConstraints) size equals: 2.
	self
		deny: (simulationGui diagramSimulator instVarNamed: #shouldRun)
		description: 'Encountering unmet constraints must pause the simulation'.
	self
		assert: simulationGui window window extent y > initialExtent y
		description: 'Adding constraint checkboxes must enlarge the simulation window height'.

	layoutPresenters := simulationGui layout children keys.
	labels := layoutPresenters select: [ :eachPresenter | eachPresenter isKindOf: SpLabelPresenter ].
	self assert: labels size equals: 1.
	self assert: labels first label equals: 'Waiting'.

	continueButtons := layoutPresenters select: [ :eachPresenter |
		                   (eachPresenter isKindOf: SpButtonPresenter) and: [ eachPresenter label = 'Continue' ] ].
	self assert: continueButtons size equals: 1.

	constraintSimulatorA := simulationGui diagramSimulator simulatorOf: constraintA.
	constraintSimulatorB := simulationGui diagramSimulator simulatorOf: constraintB.
	checkboxPairs do: [ :eachPair | eachPair first state: true ].
	self assert: constraintSimulatorA value description: 'Activating inline checkbox must enable constraint A'.
	self assert: constraintSimulatorB value description: 'Activating inline checkbox must enable constraint B'.

	(checkboxPairs detect: [ :eachPair | eachPair second == constraintSimulatorA ]) first state: false.
	self deny: constraintSimulatorA value description: 'Deactivating inline checkbox must disable constraint A'
]

{ #category : 'tests' }
OPBormSimulationGUITest >> testUpdateConstraintMenuIgnoresEmptySourceNode [

	| simpleModel participant startState endState constrainedTransition simpleConstraint project diagram projectController plugin |
	simpleModel := BormORModel named: 'Single Constraint'.
	participant := BormParticipant named: 'Participant'.
	startState := (BormState named: 'Start')
		              beInitial;
		              yourself.
	endState := (BormState named: 'End')
		            beFinal;
		            yourself.
	constrainedTransition := BormTransition from: startState to: endState.
	simpleConstraint := BormConstraint named: 'AlwaysTrue'.
	constrainedTransition constraint: simpleConstraint.
	simpleModel add: participant.
	participant addAll: {
			startState.
			endState.
			constrainedTransition }.

	project := OPProject named: 'Empty Source Node Test'.
	project addModel: simpleModel.
	diagram := OPOpenPonkDiagram forModelElement: simpleModel.
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
		model: simpleModel.
	diagramController showAllElements.

	simulationGui := OPBormSimulationGUI diagramController: diagramController.
	(simulationGui diagramSimulator simulatorOf: simpleConstraint) value: true.
	simulationGui diagramSimulator step.

	self assert: (simulationGui diagramSimulator simulatorOf: startState) tokenCount equals: 0.
	self assert: (simulationGui diagramSimulator simulatorOf: endState) tokenCount equals: 1.
	self assertEmpty: (simulationGui instVarNamed: #constraints)
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
