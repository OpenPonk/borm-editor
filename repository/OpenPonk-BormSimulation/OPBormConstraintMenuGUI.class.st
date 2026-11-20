"
Spec presenter for the BORM constraint configuration menu.
Allows users to manually set or toggle constraint values (true/false) before or during a simulation.
"
Class {
	#name : 'OPBormConstraintMenuGUI',
	#superclass : 'SpPresenter',
	#instVars : [
		'constraints',
		'diagramSimulator',
		'checkboxes'
	],
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> connectPresenters [

	checkboxes ifNotNil: [
		checkboxes do: [ :each |
			each first whenActivatedDo: [ self updateConstraints ] ].
		checkboxes do: [ :each |
			each first whenDeactivatedDo: [ self updateConstraints ] ] ]
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> initialize [

	super initialize.
	constraints := OrderedCollection new.
	checkboxes := OrderedCollection new
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> initializeLayout [

	|  gridLayout  |
	gridLayout := SpGridLayout new.
	self layout: gridLayout
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> initializePresenters [

	super initializePresenters.
	self initializeLayout
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	aWindow title: 'Constraint Menu'
]

{ #category : 'testing' }
OPBormConstraintMenuGUI >> isOpen [

	^ self hasWindow
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> setDiagramConstraints [

	| count last |
	diagramSimulator simulableElements do: [ :each |
			each outgoing do: [ :edge |
					edge model constraint ifNotNil: [ :eachConstraint |
							| pair |
							pair := {
								        each.
								        (diagramSimulator simulatorOf: eachConstraint) }.
							(constraints includes: pair) ifFalse: [ constraints add: pair ] ] ] ].
	count := 1.
	last := nil.
	constraints do: [ :constraint |
			| checkbox |
			checkbox := self newCheckBox
				            label: constraint second model name;
				            state: constraint second value;
				            yourself.
			checkboxes add: {
					checkbox.
					constraint second }.
			count := count + 1.
			self layout add: checkbox atPoint: 2 @ count.
			last = constraint first model name ifFalse: [
					| nodeLabel |
					last := constraint first model name.
					nodeLabel := self newLabel
						             label: last;
						             yourself.
					self layout add: nodeLabel atPoint: 1 @ count ] ].
	self connectPresenters
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> setDiagramSimulator: aDiagramSimulator [

	diagramSimulator := aDiagramSimulator
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> updateConstraints [

	checkboxes do: [ :constraint |
		constraint second value: constraint first state ]
]
