"
I am a Spec presenter acting as a textual DSL editor for BORM models. I provide a synchronized text area where users can write BormLang code, and I automatically update the visual diagram upon changes.
"
Class {
	#name : 'OPBormLangEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'textModel',
		'bormDiagram',
		'serializer',
		'locked'
	],
	#category : 'OpenPonk-BormEditor-Extensions',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Extensions'
}

{ #category : 'layout' }
OPBormLangEditor class >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  add: #textModel;
		  yourself
]

{ #category : 'accessing' }
OPBormLangEditor >> bormDiagram [
	^ bormDiagram
]

{ #category : 'accessing' }
OPBormLangEditor >> bormDiagram: aBormDiagram [
	bormDiagram := aBormDiagram.
	self modelChanged
]

{ #category : 'initialization' }
OPBormLangEditor >> connectPresenters [
	textModel widget announcer when: RubTextAccepted send: #textModelChanged to: self.
]

{ #category : 'initialization' }
OPBormLangEditor >> initialize [
	super initialize.
	serializer := BormLangSerializer new.
	locked := false
]

{ #category : 'initialization' }
OPBormLangEditor >> initializePresenters [
	textModel := self newRubScrolledText
]

{ #category : 'locking' }
OPBormLangEditor >> lock [
	locked := true
]

{ #category : 'locking' }
OPBormLangEditor >> locked: aBlock [
	locked
		ifTrue: [ ^ self ].
	self lock.
	aBlock value.
	self unlock
]

{ #category : 'events' }
OPBormLangEditor >> modelChanged [
	| newText |
	self traceCr: 'modelChanged'.
	newText := serializer diagram: bormDiagram.
	newText = self textModel widget text
		ifFalse: [ self traceCr: 'CHANGE' ]
]

{ #category : 'instance creation' }
OPBormLangEditor >> newRubScrolledText [

	^ RubScrolledTextMorph new
		  vResizing: #spaceFill;
		  hResizing: #spaceFill;
		  beWrapped;
		  updateTextWith: self newStartText;
		  withLineNumbers;
		  withTextSegmentIcons;
		  asSpecAdapter
]

{ #category : 'instance creation' }
OPBormLangEditor >> newStartText [
	^ 'Participant "User" {
}'
]

{ #category : 'accessing' }
OPBormLangEditor >> textModel [
	^ textModel
]

{ #category : 'events' }
OPBormLangEditor >> textModelChanged [
	| text newModel success |
	self traceCr: 'textModelChanged'.
	text := self textModel widget text.
	success := true.
	newModel := [ BormLangParser
		parse: text
		onError: [ success := false ] ] ifError: [ success := false ].
	self traceCr: success.
	success
		ifTrue: [ BormFactory moveParticipantsFrom: newModel to: bormDiagram ]
]

{ #category : 'locking' }
OPBormLangEditor >> unlock [
	locked := false
]
