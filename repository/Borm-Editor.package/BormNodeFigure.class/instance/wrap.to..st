wrapping
wrap: aText to: maxWidth
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