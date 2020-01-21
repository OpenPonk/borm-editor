Class {
	#name : #BormLangHighlighter,
	#superclass : #BormLangGrammar,
	#category : 'Borm-Editor-Dsl'
}

{ #category : #'as yet unclassified' }
BormLangHighlighter >> activity [
	^ activityStart , space , namePair
]

{ #category : #'as yet unclassified' }
BormLangHighlighter >> activityStart [
	^ super activityStart token ==> [ :token | token -> Color purple ]
]

{ #category : #'as yet unclassified' }
BormLangHighlighter >> name [
	^ super name token ==> [ :token | token -> Color green muchDarker darker ]
]

{ #category : #'as yet unclassified' }
BormLangHighlighter >> participantType [
	^ super participantType token ==> [ :token | token -> Color blue ]
]

{ #category : #'as yet unclassified' }
BormLangHighlighter >> state [
	^ ((stateType , space) optional , 'state' asParser token , space token , namePair)
		==> [ :n | 
			{n first.
			n second -> Color purple.
			n last} ]
]

{ #category : #'as yet unclassified' }
BormLangHighlighter >> stateType [
	^ super stateType token ==> [ :token | token -> Color purple ]
]
