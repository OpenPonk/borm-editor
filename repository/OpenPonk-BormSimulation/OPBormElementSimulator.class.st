Class {
	#name : 'OPBormElementSimulator',
	#superclass : 'OPElementSimulator',
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'testing' }
OPBormElementSimulator >> addInitialTokens [

	(self incoming isEmpty or: [
		 self model isState and: [ self model isInitial ] ]) ifTrue: [
		self addToken: OPBormToken new ]
]

{ #category : 'testing' }
OPBormElementSimulator >> baseCondition [
	^ self tokenCount ~= 0 and: [ self outgoing size ~= 0 ]
]

{ #category : 'accessing' }
OPBormElementSimulator >> communicationTokenCount [

	^ (self tokens select: [ :token |
		   token type = 'OPBormCommunicationSimulator' ]) size
]

{ #category : 'enumerating' }
OPBormElementSimulator >> incomingCommunications [
	^ self incoming select: [ :each | each isKindOf: OPBormCommunicationSimulator ]
]

{ #category : 'enumerating' }
OPBormElementSimulator >> incomingTransitions [

	^ self incoming select: [ :each |
		  each isKindOf: OPBormTransitionSimulator ]
]

{ #category : 'testing' }
OPBormElementSimulator >> inputCommunicationCondition [

	(model inputCommunicationSimulationCondition nameAsInput = 'Any'
		 and: [ self incomingCommunications isNotEmpty ]) ifTrue: [
		^ self communicationTokenCount > 0 ].
	model inputCommunicationSimulationCondition nameAsInput = 'All'
		ifTrue: [
			^ self communicationTokenCount >= self incomingCommunications size].

	^ true
]

{ #category : 'testing' }
OPBormElementSimulator >> inputCondition [

	^ self inputCommunicationCondition and: [
		  self inputTransitionCondition ]
]

{ #category : 'testing' }
OPBormElementSimulator >> inputTransitionCondition [

	(model inputTransitionSimulationCondition nameAsInput = 'Any' and: [
		 self incomingTransitions isNotEmpty ]) ifTrue: [
		^ self transitionTokenCount > 0 ].
	model inputTransitionSimulationCondition nameAsInput = 'All' ifTrue: [
		^ self transitionTokenCount >= self incomingTransitions size].
	^ true
]

{ #category : 'testing' }
OPBormElementSimulator >> isSimulable [

	^ true
]

{ #category : 'testing' }
OPBormElementSimulator >> isSteppable [

	^ self inputCondition and: [ self outputCondition ]
]

{ #category : 'testing' }
OPBormElementSimulator >> openConstraintMenu [

	| constraintWindow constraints constraintSimulator |
	constraints := OrderedCollection new.
	constraintWindow := OPBormConstraintMenuGUI new.
	self outgoing do: [ :each |
		each model constraint ifNotNil: [
			constraintSimulator := diagramSimulator simulatorOf: each model constraint.
			constraints add: constraintSimulator
				 ] ] .
	constraintWindow setConstraints: constraints.
	constraintWindow open
]

{ #category : 'testing' }
OPBormElementSimulator >> outputCondition [

	| constraintSimulator |
	model outputSimulationCondition nameAsOutput = 'Any' ifTrue: [
		self outgoing do: [ :each |
			each model constraint ifNotNil: [
				constraintSimulator := self diagramSimulator simulatorOf:
					                       each model constraint.
				constraintSimulator value ifTrue: [ ^ self baseCondition ] ] ].
		^ false ].
	model outputSimulationCondition nameAsOutput = 'All' ifTrue: [
		self outgoing do: [ :each |
			each model constraint ifNotNil: [
				constraintSimulator := self diagramSimulator simulatorOf:
					                       each model constraint.
				constraintSimulator value ifFalse: [ ^ false ] ] ].
		^ self baseCondition ].
	^ self baseCondition
]

{ #category : 'printing' }
OPBormElementSimulator >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(.
	stream << self tokenCount asString.
	stream nextPut: $)
]

{ #category : 'actions' }
OPBormElementSimulator >> process [

	| constraintSimulator token |
	self outgoing do: [ :each |
		token := self tokens anyOne copy.
		token type: each class asString.
		each model constraint
			ifNil: [ each target addToken: token ]
			ifNotNil: [
				constraintSimulator := self diagramSimulator simulatorOf:
					                       each model constraint.
				(constraintSimulator value or: [
					 self model outputSimulationCondition nameAsOutput = 'None' ])
					ifTrue: [ each target addToken: token ] ] ].
	self removeAllTokens
]

{ #category : 'initialization' }
OPBormElementSimulator >> setDefaultStepping [
	"sets default stepping settings"

	super setDefaultStepping.
	self
		resetActions;
		selectAll;
		addAction: [ :item | item process ]
]

{ #category : 'accessing' }
OPBormElementSimulator >> transitionTokenCount [

	^ (self tokens select: [ :token |
		   token type = 'OPBormTransitionSimulator' ]) size
]
