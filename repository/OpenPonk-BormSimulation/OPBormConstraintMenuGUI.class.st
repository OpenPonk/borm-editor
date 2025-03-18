Class {
	#name : 'OPBormConstraintMenuGUI',
	#superclass : 'SpPresenter',
	#instVars : [
		'constraints',
		'buttons',
		'label',
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

	constraints := OrderedCollection new.
	checkboxes := OrderedCollection new.
	super initialize
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

	aWindow title: 'Constraint Menu'
]

{ #category : 'testing' }
OPBormConstraintMenuGUI >> isOpen [

	^ self hasWindow
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> setConstraints: modelConstraints [

	| count button buttonPair |
	constraints := modelConstraints.
	count := 1.
	constraints do: [ :each |
		buttons add: {
				self newCheckBox.
				each }.
		buttonPair := buttons at: count.
		button := buttonPair first.
		count := count + 1.
		label := self newLabel.
		button label: each model name.
		button state: buttonPair second value.
		button extent: 200 @ 30.
		self layout add: button expand: false].
	self connectPresenters
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> setDiagramConstraints [

	| count button buttonPair constraintSimulator last tmp |
	count := 1.
	diagramSimulator simulableElements do: [ :each |
		each outgoing do: [ :edge |
			edge model constraint ifNotNil: [
				constraintSimulator := diagramSimulator simulatorOf:
					                       edge model constraint.
				(constraints includes: {
						 each.
						 constraintSimulator }) ifFalse: [
					constraints add: {
							each.
							constraintSimulator } ] ] ] ].
	last := nil.
	constraints do: [ :constraint |
		checkboxes add: {
				self newCheckBox.
				constraint second }.
		buttonPair := checkboxes at: count.
		button := buttonPair first.
		count := count + 1.
		button label: constraint second model name.
		button state: buttonPair second value.

		self layout add: button at: 2 @ count.

		self connectPresenters.
		last = constraint first model name ifFalse: [
			last := constraint first model name.
			tmp := self newLabel.
			tmp label: constraint first model name.
			self layout add: tmp at: 1 @ count ] ]
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> setDiagramSimulator: aDiagramSimulator [

	diagramSimulator := aDiagramSimulator
]

{ #category : 'private - hooks' }
OPBormConstraintMenuGUI >> simulatorClass [

	^ OPBormSimulator
]

{ #category : 'initialization' }
OPBormConstraintMenuGUI >> updateConstraints [

	checkboxes do: [ :constraint |
		constraint second value: constraint first state ]
]
