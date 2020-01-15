accessing
baseline: spec
	<baseline>
	spec
		for: #common
		do:
			[ spec
				baseline: 'BormModel'
				with: [ spec repository: 'github://openponk/borm-model/repository' ].
			spec
				baseline: 'OpenPonk'
				with: [ spec repository: 'github://openponk/openponk/repository' ].
			spec
				baseline: 'XMLParser'
				with: [ spec repository: 'github://pharo-contributions/XML-XMLParser/src' ].
			spec
				baseline: 'XPath'
				with: [ spec repository: 'github://pharo-contributions/XML-XPath/src' ].
			spec
				baseline: 'PetitParser'
				with: [ spec repository: 'github://moosetechnology/PetitParser/src' ].
			spec package: 'Borm-Editor' with: [ spec requires: #('BormModel' 'PetitParser') ].
			spec group: 'plugin' with: #('Borm-Editor').
			spec group: 'default' with: #('plugin' 'OpenPonk') ]