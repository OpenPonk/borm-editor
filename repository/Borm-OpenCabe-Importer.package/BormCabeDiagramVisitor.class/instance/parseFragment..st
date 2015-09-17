as yet unclassified
parseFragment: aString
	| rx parts |
	rx := '//?([^/])+' asRegex.
	^ rx
		matchesIn: aString
		collect:
			[ :each | 
			parts := each splitOn: $..
			{(parts first copyWithoutAll: #//@).
			(parts second asNumber + 1)} ]