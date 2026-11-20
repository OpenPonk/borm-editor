"
Simulation GUI presenter for BORM diagrams.
Extends the base simulation GUI with specific controls for toggling constraints, updating data flow colors, and providing step-by-step execution feedback.
"
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

{ #category : 'adding' }
OPBormSimulationGUI >> addCheckboxForConstraint: aConstraint [

	| checkbox |
	usedConstraints add: aConstraint.
	checkbox := self newCheckBox
		            label: aConstraint second model name;
		            state: aConstraint second value;
		            yourself.
	checkbox
		whenActivatedDo: [ self updateConstraints ];
		whenDeactivatedDo: [ self updateConstraints ].
	checkboxes add: {
			checkbox.
			aConstraint second }.
	count := count + 1.
	self layout add: checkbox atPoint: self calculateButtonPosition
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
OPBormSimulationGUI >> addLabelIfNeededForConstraint: aConstraint last: aLast [

	| label |
	aConstraint first model name = aLast ifTrue: [ ^ self ].
	label := self newLabel.
	label label: aConstraint first model name.
	self layout add: label atPoint: self calculateLabelPosition
]

{ #category : 'positioning' }
OPBormSimulationGUI >> adjustWindowSize [

	self withWindowDo: [ :win |
			| rowCount height |
			rowCount := buttons size + 1.
			height := rowCount * self class buttonHeight + (constraints size * 30) + 10.
			win resize: 360 @ height ]
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

{ #category : 'private - updating' }
OPBormSimulationGUI >> colorForElement: anElement controller: aController [

	anElement isSteppable ifTrue: [ ^ Color green ].
	anElement tokenCount > 0 ifFalse: [ ^ aController diagramElement defaultBackgroundColor ].
	(anElement outgoing isEmpty and: [ anElement inputCondition ]) ifTrue: [ ^ Color pink ].
	^ Color lightOrange lighter
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
OPBormSimulationGUI >> getUnusedConstraints [

	^ constraints reject: [ :each | usedConstraints includes: each ]
]

{ #category : 'initialization' }
OPBormSimulationGUI >> initialize [

	super initialize.
	presetSimulation := true.
	constraints := OrderedCollection new.
	usedConstraints := OrderedCollection new.
	checkboxes := OrderedCollection new.
	count := 1
]

{ #category : 'adding' }
OPBormSimulationGUI >> layoutContinueButton: aButton [

	self layout add: aButton atPoint: 1 @ (count + 1 + (self buttonItems size + 1 / 2) asInteger)
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

{ #category : 'private - accessing' }
OPBormSimulationGUI >> renderedControllerForModel: aModel ifPresent: aBlock [

	| controller |
	controller := self diagramController controllerForModel: aModel ifNone: [ ^ self ].
	controller diagramElement exists ifFalse: [ ^ self ].
	controller roassalShape ifNil: [ ^ self ].
	aBlock value: controller
]

{ #category : 'private - hooks' }
OPBormSimulationGUI >> simulatorClass [
	^ OPBormSimulator
]

{ #category : 'updating' }
OPBormSimulationGUI >> updateColors [

	| steppableElements |
	diagramSimulator elements select: [ :each | each isKindOf: OPBormDataFlowSimulator ] thenDo: [ :each |
			self renderedControllerForModel: each model ifPresent: [ :controller |
					controller roassalShape
						color: Color transparent;
						signalUpdate ] ].
	steppableElements := OrderedCollection new.
	diagramSimulator simulableElements do: [ :each |
			each isSteppable ifTrue: [ steppableElements add: each ].
			self renderedControllerForModel: each model ifPresent: [ :controller |
					controller roassalShape
						color: (self colorForElement: each controller: controller);
						signalUpdate ] ].
	steppableElements do: [ :each | self updateDataFlowColors: each ]
]

{ #category : 'updating' }
OPBormSimulationGUI >> updateConstraintMenu [

	| constraintSimulator toBeStopped |
	presetSimulation ifTrue: [ ^ self ].
	toBeStopped := false.

	diagramSimulator simulableElements do: [ :each |
			(each tokenCount > 0 and: [ each outputCondition not and: [ each inputCondition ] ]) ifTrue: [
					each outgoing do: [ :edge |
							edge model constraint ifNotNil: [ :eachConstraint |
									| pair |
									constraintSimulator := diagramSimulator simulatorOf: eachConstraint.
									pair := {
										        each.
										        constraintSimulator }.
									(constraints includes: pair) ifFalse: [
											toBeStopped := true.
											constraints add: pair ] ] ] ] ].
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

	aModel outgoing select: [ :eachEntity | eachEntity isKindOf: OPBormCommunicationSimulator ] thenDo: [ :each |
			each model dataFlows ifNotEmpty: [ :dataFlows |
					self renderedControllerForModel: each target model ifPresent: [ :targetController |
							targetController roassalShape
								color: Color yellow;
								signalUpdate ].
					dataFlows do: [ :dataFlow |
							self renderedControllerForModel: dataFlow ifPresent: [ :dataFlowController |
									dataFlowController roassalShape
										color: Color yellow;
										signalUpdate ] ] ] ]
]
