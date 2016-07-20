as yet unclassified
wrap: aText to: aMaxWidth font: aFont
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