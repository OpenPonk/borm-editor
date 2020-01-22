Class {
	#name : #BormNodeFigure,
	#superclass : #BormFigure,
	#instVars : [
		'text',
		'plusIcon'
	],
	#category : #'OpenPonk-BormEditor-Visuals'
}

{ #category : #rendering }
BormNodeFigure >> addInteractions [
	self @ RTDraggableSnapToGrid.
	self @ RTResizable
]

{ #category : #'creating - subelements' }
BormNodeFigure >> createOwnedElements [
	| block |
	text := self figuresFactory newText
		text: [ :m | m model ifNil: '' ifNotNil: #name ];
		wrapText;
		elementOn: self.
	self add: text.
	(RTConstraint on: text background: self) stick.
	block := [ :aShape :step | 
	text shape width: aShape width - 20.
	text update ].
	self addCallback: (TRTranslationCallback block: block).
	self addCallback: (TRExtentCallback block: block).
	plusIcon := RTBitmap new
		form: (self iconNamed: #add);
		element.
	(RTConstraint on: plusIcon background: self)
		right;
		bottom;
		padding: 5;
		stick
]

{ #category : #defaults }
BormNodeFigure >> defaultSize [
	^ 150 @ 60
]

{ #category : #accessing }
BormNodeFigure >> plusIcon [
	^ plusIcon
]

{ #category : #accessing }
BormNodeFigure >> text [
	^ text
]

{ #category : #updating }
BormNodeFigure >> update [
	self show: plusIcon if: self model submodel isNotNil.
	super update
]

{ #category : #wrapping }
BormNodeFigure >> wrap: aText to: maxWidth [
	| string font words lineWidth lines line ww |
	string := aText copyReplaceAll: String cr with: ' '.
	font := RTTheme current textFont.
	words := string splitOn: ' '.
	lineWidth := 0.
	lines := OrderedCollection new.
	line := OrderedCollection new.
	lines add: line.
	words
		do: [ :word | 
			ww := font widthOfString: word.
			lineWidth = 0
				ifTrue: [ line add: word.
					lineWidth := lineWidth + ww ]
				ifFalse: [ ww + lineWidth > maxWidth
						ifTrue: [ lineWidth := 0.
							line := OrderedCollection new.
							lines add: line ].
					line add: word.
					lineWidth := lineWidth + ww ] ].
	^ (lines collect: [ :each | each joinUsing: ' ' ]) joinUsing: String cr
]

{ #category : #'as yet unclassified' }
BormNodeFigure >> wrap: aText to: aMaxWidth font: aFont [
	| string words lineWidth lines line ww |
	string := aText copyReplaceAll: String cr with: ' '.
	words := string splitOn: ' '.
	lineWidth := 0.
	lines := OrderedCollection new.
	line := OrderedCollection new.
	lines add: line.
	words
		do: [ :word | 
			ww := aFont widthOfString: word.
			lineWidth = 0
				ifTrue: [ line add: word.
					lineWidth := lineWidth + ww ]
				ifFalse: [ ww + lineWidth > aMaxWidth
						ifTrue: [ lineWidth := 0.
							line := OrderedCollection new.
							lines add: line ]
						ifFalse: [ line add: word.
							lineWidth := lineWidth + ww ] ] ].
	^ (lines collect: [ :each | each joinUsing: ' ' ]) joinUsing: String cr
]
