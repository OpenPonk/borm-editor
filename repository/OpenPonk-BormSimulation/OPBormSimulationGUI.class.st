Class {
	#name : 'OPBormSimulationGUI',
	#superclass : 'OPSimulationGUI',
	#instVars : [
		'presetSimulation',
		'constraints',
		'checkboxes',
		'usedConstraints',
		'count'
	],
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'toolbar' }
OPBormSimulationGUI class >> toolbarMenu: aBuilder [
	<opEditorToolbarMenu: #OPBormPlugin>
	self toolbarMenuItemFor: aBuilder
]

{ #category : 'adding' }
OPBormSimulationGUI >> addCheckboxForConstraint: aConstraint [

	| buttonPair button |
	usedConstraints add: aConstraint.
	checkboxes add: {
			self newCheckBox.
			aConstraint second }.
	self connectPresenters.
	buttonPair := checkboxes at: count.
	button := buttonPair first.
	count := count + 1.
	button label: aConstraint second model name.
	button state: buttonPair second value.
	self layout add: button at: self calculateButtonPosition
]

{ #category : 'adding' }
OPBormSimulationGUI >> addConstraintCheckboxes [

	| toBeAdded last continueButton |
	last := ''.
	toBeAdded := self getUnusedConstraints.

	toBeAdded do: [ :constraint |
		self addCheckboxForConstraint: constraint.
		self addLabelIfNeededForConstraint: constraint last: last.
		last := constraint first model name ].

	continueButton := self createContinueButton.
	self layoutContinueButton: continueButton.
	self adjustWindowSize
]

{ #category : 'adding' }
OPBormSimulationGUI >> addConstraintCheckboxess [

	| toBeAdded last continueButton |
	last := ''.
	toBeAdded := self getUnusedConstraints.

	toBeAdded do: [ :constraint |
		self addCheckboxForConstraint: constraint.
		self addLabelIfNeededForConstraint: constraint last: last.
		last := constraint first model name ].

	continueButton := self createContinueButton.
	self layoutContinueButton: continueButton.
	self adjustWindowSize
]

{ #category : 'adding' }
OPBormSimulationGUI >> addLabelIfNeededForConstraint: aConstraint last: aLast [

	| label |
	aConstraint first model name = aLast ifTrue: [ ^ self ].
	label := self newLabel.
	label label: aConstraint first model name.
	self layout add: label at: self calculateLabelPosition
]

{ #category : 'positioning' }
OPBormSimulationGUI >> adjustWindowSize [

	self window extent: 360
		@
			(buttons size + 1 * self class buttonHeight
			 + (constraints size * 30) + 10)
]

{ #category : 'private - hooks' }
OPBormSimulationGUI >> buttonItems [

	^ {
		  (self newButton
			   label: 'Pause';
			   iconName: #testYellow;
			   help: 'Pause stepping';
			   action: [ self diagramSimulator stop ]).
		  (self newButton
			   label: 'Play';
			   iconName: #smallPrintItIcon;
			   help: 'Steps all elements every second';
			   action: [ self diagramSimulator repeat ]).
		  (self newButton
			   label: 'Step all';
			   iconName: #forwardIcon;
			   help: 'Steps all elements once';
			   action: [ self diagramSimulator step ]).
		  (self newButton
			   label: 'Set constraints';
			   help: 'Opens menu to set what constraints are true';
			   action: [ self openConstraintMenu ]) }
]

{ #category : 'positioning' }
OPBormSimulationGUI >> calculateButtonPosition [
    ^ 2 @ (count + (self buttonItems size / 2) asInteger)
]

{ #category : 'positioning' }
OPBormSimulationGUI >> calculateLabelPosition [
    ^ 1 @ (count + (self buttonItems size / 2) asInteger)
]

{ #category : 'initialization' }
OPBormSimulationGUI >> connectPresenters [

	checkboxes ifNotNil: [
		checkboxes do: [ :each |
			each first whenActivatedDo: [ self updateConstraints ] ].
		checkboxes do: [ :each |
			each first whenDeactivatedDo: [ self updateConstraints ] ] ]
]

{ #category : 'adding' }
OPBormSimulationGUI >> createContinueButton [
    ^ self newButton
        label: 'Continue';
        iconName: #smallPrintItIcon;
        help: 'Continues the simulation';
        action: [ self diagramSimulator repeat ]
]

{ #category : 'enumerating' }
OPBormSimulationGUI >> filterConstraints [

	^ diagramSimulator elements select: [ :each |
		  each class name = 'OPBormConstraintSimulator' ]
]

{ #category : 'enumerating' }
OPBormSimulationGUI >> getUnusedConstraints [

	^ constraints reject: [ :each | usedConstraints includes: each ]
]

{ #category : 'initialization' }
OPBormSimulationGUI >> initialize [
	presetSimulation := true.
	constraints := OrderedCollection new.
	usedConstraints := OrderedCollection new.
	checkboxes := OrderedCollection new.
	count := 1.
	super initialize
]

{ #category : 'adding' }
OPBormSimulationGUI >> layoutContinueButton: aButton [
    self layout
        add: aButton
        at: 1 @ (count + 1 + (self buttonItems size + 1 / 2) asInteger)
]

{ #category : 'private - hooks' }
OPBormSimulationGUI >> loadSimulation [
	"prepares simulation - called with every reload"

	super loadSimulation.
	diagramSimulator
		when: OPSimulatorStepped
		do: [ :event |
			self updateColors.
			self updateConstraintMenu ]
		for: self.
	self updateColors
]

{ #category : 'showing' }
OPBormSimulationGUI >> open [

	self isOpen ifFalse: [ presetSimulation := false ].
	super open
]

{ #category : 'showing' }
OPBormSimulationGUI >> openConstraintMenu [

	| constraintWindow |
	presetSimulation := true.
	constraintWindow := OPBormConstraintMenuGUI new.
	constraintWindow setDiagramSimulator: diagramSimulator.
	constraintWindow setDiagramConstraints.

	constraintWindow open
]

{ #category : 'private - hooks' }
OPBormSimulationGUI >> simulatorClass [
	^ OPBormSimulator
]

{ #category : 'updating' }
OPBormSimulationGUI >> updateColors [

	diagramSimulator elements do: [ :each |
		| controller |
		each class name = 'OPBormDataFlowSimulator' ifTrue: [
			controller := self diagramController controllerForModel: each model.
			controller roassalShape color: Color transparent ] ].
	diagramSimulator simulableElements do: [ :each |
		| controller color |
		controller := self diagramController controllerForModel: each model.
		color := each isSteppable
			         ifTrue: [
				         self updateDataFlowColors: each.
				         Color green ]
			         ifFalse: [
				         each tokenCount > 0
					         ifTrue: [
						         (each outgoing isEmpty and: [ each inputCondition ])
							         ifTrue: [ Color pink ]
							         ifFalse: [ Color lightOrange lighter ] ]
					         ifFalse: [
					         controller diagramElement defaultBackgroundColor ] ].
		controller roassalShape color: color.
		controller roassalShape signalUpdate ]
]

{ #category : 'updating' }
OPBormSimulationGUI >> updateConstraintMenu [

	| constraintSimulator toBeStopped |
	presetSimulation ifTrue: [ ^ self ].
	toBeStopped := false.

	diagramSimulator simulableElements do: [ :each |
		each outputCondition ifFalse: [
			each inputCondition ifTrue: [
				each outgoing do: [ :edge |
					edge model constraint ifNotNil: [
						constraintSimulator := diagramSimulator simulatorOf:
							                       edge model constraint.
						(constraints includes: {
								 each.
								 constraintSimulator }) ifFalse: [
							toBeStopped := true.
							constraints add: {
									each.
									constraintSimulator } ] ] ] ] ] ].
	toBeStopped ifFalse: [ ^ self ].
	self addConstraintCheckboxes.
	diagramSimulator stop
]

{ #category : 'updating' }
OPBormSimulationGUI >> updateConstraints [

	checkboxes do: [ :constraint |
		constraint second value: constraint first state ]
]

{ #category : 'updating' }
OPBormSimulationGUI >> updateDataFlowColors: aModel [

	| dataFlowController targetController |
	aModel outgoing
		select: [ :eachEntity |
		eachEntity isKindOf: OPBormCommunicationSimulator ]
		thenDo: [ :each |
			each model dataFlows ifNotNil: [
				targetController := self diagramController controllerForModel:
					                    each target model.
				targetController roassalShape color: Color yellow.
				targetController roassalShape signalUpdate.
				each model dataFlows do: [ :dataFlow |
					dataFlowController := self diagramController controllerForModel:
						                      dataFlow.
					dataFlowController roassalShape color: Color yellow.
					dataFlowController roassalShape signalUpdate ] ] ]
]
