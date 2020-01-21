"
I take a BORM model and produce its BormLang string representation.

!! Synchronization
The inverse operation (taking DSL and parsing it) is provided by BormLangGrammar/BormLangParser
"
Class {
	#name : #BormLangSerializer,
	#superclass : #Object,
	#instVars : [
		'diagram'
	],
	#category : 'Borm-Editor-Dsl'
}

{ #category : #'public-exporting' }
BormLangSerializer class >> export: aDiagram [
	^ self new diagram: aDiagram
]

{ #category : #converting }
BormLangSerializer >> activity: anActivity [
	^ 'activity ' , (self name: anActivity name)
]

{ #category : #converting }
BormLangSerializer >> activityNode: anActivity [
	^ (self activity: anActivity) , (self newLineIf: anActivity sent isNotEmpty), (self communications: anActivity sent)
]

{ #category : #converting }
BormLangSerializer >> communication: aCommunication [
	| to flows |
	to := aCommunication receiver.
	flows := aCommunication dataFlows.

	^ flows isEmpty
		ifTrue: [ 'talk to ' , (self name: to owner name , '::' , to name) ]
		ifFalse:
			[ 
			'send ' , (self name: flows first name) , ' to '
				, (self name: to owner name , '::' , to name)
				,
					(flows size > 1
						ifTrue: [ ' and receive ' , (self name: flows second name) ]
						ifFalse: [ '' ]) ]
]

{ #category : #converting }
BormLangSerializer >> communications: aCollection [
	^ (aCollection collect: [ :each | self tab , self tab , (self communication: each) ]) joinUsing: self newLine
]

{ #category : #converting }
BormLangSerializer >> constraint: aConstraint [
	^ aConstraint ifNil: [ '' ] ifNotNil: [ ' if ' , (self name: aConstraint name) ]
]

{ #category : #exporting }
BormLangSerializer >> export: aModel [
	^ self ormodel: aModel
]

{ #category : #converting }
BormLangSerializer >> name: aString [
	^ '"' , aString , '"'
]

{ #category : #accessing }
BormLangSerializer >> newLine [
	^ Character cr asString
]

{ #category : #accessing }
BormLangSerializer >> newLineIf: aBoolean [
	^ aBoolean
		ifTrue: [ self newLine ]
		ifFalse: [ '' ]
]

{ #category : #converting }
BormLangSerializer >> node: aNode [
	^ ((aNode isKindOf: BormActivity)
		ifTrue: [ self activityNode: aNode ]
		ifFalse: [ self state: aNode ]) , (self newLineIf: aNode outgoing isNotEmpty), (self transitions: aNode outgoing)
]

{ #category : #converting }
BormLangSerializer >> nodes: aCollection [
	^ (aCollection collect: [ :each | self tab , (self node: each) ]) joinUsing: self newLine , self newLine
]

{ #category : #converting }
BormLangSerializer >> ormodel: aModel [
	^ self participants: aModel participants
]

{ #category : #converting }
BormLangSerializer >> participant: aParticipant [
	^ (self participantType: aParticipant type) , ' ' , (self name: aParticipant name) , ' ' , '{' , self newLine
		, (self nodes: aParticipant nodes) , self newLine , '}'
]

{ #category : #converting }
BormLangSerializer >> participantType: aType [
	^ aType asString
]

{ #category : #converting }
BormLangSerializer >> participants: aCollection [
	^ (aCollection collect: [ :each | self participant: each ])
		joinUsing: self newLine , self newLine
]

{ #category : #converting }
BormLangSerializer >> state: aState [
	^ (self stateType: aState) , 'state' , ' ' , (self name: aState name)
]

{ #category : #converting }
BormLangSerializer >> stateType: aState [
	aState isInitial & aState isFinal
		ifTrue: [ ^ 'initial and final ' ].

	aState isInitial
		ifTrue: [ ^ 'initial ' ].

	aState isFinal
		ifTrue: [ ^ 'final ' ].

	^ ''
]

{ #category : #accessing }
BormLangSerializer >> tab [
	^ Character tab asString
]

{ #category : #converting }
BormLangSerializer >> transition: aTransition [
	^ 'go to ' , (self name: aTransition target name) , (self constraint: aTransition constraint)
]

{ #category : #converting }
BormLangSerializer >> transitions: aCollection [
	^ (aCollection collect: [ :each | self tab , self tab , (self transition: each) ]) joinUsing: self newLine
]
