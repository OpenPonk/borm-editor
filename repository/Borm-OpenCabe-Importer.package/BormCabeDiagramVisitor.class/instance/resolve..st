as yet unclassified
resolve: aString
	| uri fragment selector position |
	uri := XMLURI fromString: aString.
	uri pathSegments last = 'entities.xmi'
		ifTrue:
			[ 
			fragment := $. split: uri fragment.
			selector := fragment first.
			position := fragment last asNumber.
			^ entityNames at: position + 1 ].
	^ self resolveFragment: aString