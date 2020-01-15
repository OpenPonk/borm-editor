accessing
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'BormModel'
				with: [ spec
						repository: 'github://openponk/borm-model/repository';
						postLoadDoIt: #loadPetitParser ].
			spec
				baseline: 'OpenPonk'
				with: [ spec repository: 'github://openponk/openponk/repository' ].
			spec
				baseline: 'XMLParser'
				with: [ spec
						repository: 'github://pharo-contributions/XML-XMLParser:3.5.x/src' ].
			spec
				baseline: 'XPath'
				with:
					[ spec repository: 'github://pharo-contributions/XML-XPath:2.2.0/src' ].
			spec package: 'Borm-Editor' with: [ spec requires: #('BormModel') ].
			spec group: 'plugin' with: #('Borm-Editor').
			spec group: 'default' with: #('plugin' 'OpenPonk') ]