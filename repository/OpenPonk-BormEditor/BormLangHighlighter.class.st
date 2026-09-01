"
I extend the BormLang grammar to provide syntax highlighting rules for the BormLang textual DSL editor.
"
Class {
	#name : 'BormLangHighlighter',
	#superclass : 'BormLangGrammar',
	#category : 'OpenPonk-BormEditor-Dsl',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Dsl'
}

{ #category : 'accessing' }
BormLangHighlighter >> activity [
	^ activityStart , space , namePair
]

{ #category : 'accessing' }
BormLangHighlighter >> activityStart [
	^ super activityStart token ==> [ :token | token -> Color purple ]
]

{ #category : 'accessing' }
BormLangHighlighter >> name [
	^ super name token ==> [ :token | token -> Color green muchDarker darker ]
]

{ #category : 'accessing' }
BormLangHighlighter >> participantType [
	^ super participantType token ==> [ :token | token -> Color blue ]
]

{ #category : 'accessing' }
BormLangHighlighter >> state [
	^ ((stateType , space) optional , 'state' asParser token , space token , namePair)
		==> [ :n | 
			{n first.
			n second -> Color purple.
			n last} ]
]

{ #category : 'accessing' }
BormLangHighlighter >> stateType [
	^ super stateType token ==> [ :token | token -> Color purple ]
]
