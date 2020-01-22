Class {
	#name : #OPBormLangEditor,
	#superclass : #ComposablePresenter,
	#instVars : [
		'textModel',
		'bormDiagram',
		'serializer',
		'locked'
	],
	#category : #'OpenPonk-BormEditor-Extensions'
}

{ #category : #specs }
OPBormLangEditor class >> defaultSpec [
	^ SpecLayout composed newRow: [ :row | row add: #textModel ]
]

{ #category : #accessing }
OPBormLangEditor >> bormDiagram [
	^ bormDiagram
]

{ #category : #accessing }
OPBormLangEditor >> bormDiagram: aBormDiagram [
	bormDiagram := aBormDiagram.
	self modelChanged
]

{ #category : #initialization }
OPBormLangEditor >> initialize [
	super initialize.
	serializer := BormLangSerializer new.
	locked := false
]

{ #category : #initialization }
OPBormLangEditor >> initializePresenter [
	textModel widget announcer when: RubTextAccepted send: #textModelChanged to: self.
]

{ #category : #initialization }
OPBormLangEditor >> initializeWidgets [
	textModel := self newRubScrolledText
]

{ #category : #locking }
OPBormLangEditor >> lock [
	locked := true
]

{ #category : #locking }
OPBormLangEditor >> locked: aBlock [
	locked
		ifTrue: [ ^ self ].
	self lock.
	aBlock value.
	self unlock
]

{ #category : #events }
OPBormLangEditor >> modelChanged [
	|newText|
	self logCr: 'modelChanged'.
	newText := serializer diagram: bormDiagram.
	newText = self textModel widget text ifFalse: [ 
		self logCr: 'CHANGE'
	]
	"self textModel widget updateTextWith: (serializer diagram: bormDiagram)"
]

{ #category : #'instance creation' }
OPBormLangEditor >> newRubScrolledText [
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
OPBormLangEditor >> newStartText [
	^ 'Participant "User" {
}'
]

{ #category : #accessing }
OPBormLangEditor >> textModel [
	^ textModel
]

{ #category : #events }
OPBormLangEditor >> textModelChanged [
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
OPBormLangEditor >> unlock [
	locked := false
]
