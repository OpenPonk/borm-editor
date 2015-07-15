*Borm-Editor-DslParser
gtBormInspectorPresentation: composite
	<gtInspectorPresentationOrder: 30>
	(self className beginsWith: 'Borm')
		ifTrue: [ 
			| m e |
			e := BormLangExporter new.
			m := ((self className splitOn: 'Borm') last asLowercase, ':') asSymbol.
			(e respondsTo: m)
				ifTrue: [ 
					composite rubricText
						title: 'Lang';
						display: [ e perform: m with: self ] ] ]