Class {
	#name : #BormLangEditor,
	#superclass : #ComposableModel,
	#instVars : [
		'textModel',
		'bormDiagram',
		'serializer',
		'locked'
	],
	#category : 'Borm-Editor-Extensions'
}

{ #category : #specs }
BormLangEditor class >> defaultSpec [
	^ SpecLayout composed newRow: [ :row | row add: #textModel ]
]

{ #category : #accessing }
BormLangEditor >> bormDiagram [
	^ bormDiagram
]

{ #category : #accessing }
BormLangEditor >> bormDiagram: aBormDiagram [
	bormDiagram := aBormDiagram.
	self modelChanged
]

{ #category : #initialization }
BormLangEditor >> initialize [
	super initialize.
	serializer := BormLangSerializer new.
	locked := false
]

{ #category : #initialization }
BormLangEditor >> initializePresenter [
	textModel widget announcer when: RubTextAccepted send: #textModelChanged to: self.
]

{ #category : #initialization }
BormLangEditor >> initializeWidgets [
	textModel := self newRubScrolledText
]

{ #category : #locking }
BormLangEditor >> lock [
	locked := true
]

{ #category : #locking }
BormLangEditor >> locked: aBlock [
	locked
		ifTrue: [ ^ self ].
	self lock.
	aBlock value.
	self unlock
]

{ #category : #events }
BormLangEditor >> modelChanged [
	|newText|
	self logCr: 'modelChanged'.
	newText := serializer diagram: bormDiagram.
	newText = self textModel widget text ifFalse: [ 
		self logCr: 'CHANGE'
	]
	"self textModel widget updateTextWith: (serializer diagram: bormDiagram)"
]

{ #category : #'instance creation' }
BormLangEditor >> newRubScrolledText [
	^ RubScrolledTextMorph new
				vResizing: #spaceFill; 
      			hResizing: #spaceFill;
				beWrapped;
				autoAccept: true;
				updateTextWith: self newStartText;
				withLineNumbers;
				withTextSegmentIcons;
				asSpecAdapter.
]

{ #category : #'instance creation' }
BormLangEditor >> newStartText [
	^ 'Participant "User" {
}'
]

{ #category : #accessing }
BormLangEditor >> textModel [
	^ textModel
]

{ #category : #events }
BormLangEditor >> textModelChanged [
	| text newModel success |
	self logCr: 'textModelChanged'.
	text := self textModel widget text.
	success := true.
	newModel := [ BormLangParser parse: text onError: [ success := false ] ] ifError: [ success := false ].
	self logCr: success.
	success
		ifTrue: [ BormFactory moveParticipantsFrom: newModel to: bormDiagram ]
]

{ #category : #locking }
BormLangEditor >> unlock [
	locked := false
]
