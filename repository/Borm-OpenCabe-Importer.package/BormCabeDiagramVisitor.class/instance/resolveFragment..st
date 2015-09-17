as yet unclassified
resolveFragment: aString
	| fragment first element |
	fragment := self parseFragment: aString.
	first := fragment removeFirst.
	element := (document xPath: '*/' , first first) at: first second.
	fragment do: [ :each | element := element / each first at: each second ].
	^ element