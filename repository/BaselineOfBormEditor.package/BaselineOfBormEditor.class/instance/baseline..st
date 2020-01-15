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
				with: [ spec repository: 'github://pharo-contributions/XML-XMLParser:3.5.x/src' ].
			spec
				baseline: 'XPath'
				with: [ spec repository: 'github://pharo-contributions/XML-XPath:2.2.0/src' ].
			spec
				baseline: 'PetitParser'
				with: [ spec repository: 'github://moosetechnology/PetitParser:v2.2.x/src' ].
			spec package: 'Borm-Editor' with: [ spec requires: #('BormModel' 'PetitParser') ].
			spec group: 'plugin' with: #('Borm-Editor').
			spec group: 'default' with: #('plugin' 'OpenPonk') ]