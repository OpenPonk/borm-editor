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
				project: 'XMLParser'
				with:
					[ spec
						className: #ConfigurationOfXMLParser;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ].
			spec
				project: 'XPath'
				with:
					[ spec
						className: #ConfigurationOfXPath;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XPath/main/' ].
			spec
				project: 'XPath'
				with:
					[ spec
						className: #ConfigurationOfXPath;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ].
			spec
				project: 'PetitParser'
				with:
					[ spec
						className: #ConfigurationOfPetitParser;
						versionString: #development;
						loads: #('Parser');
						repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ].
			spec package: 'Borm-Editor' with: [ spec requires: #('BormModel' 'PetitParser') ].
			spec group: 'plugin' with: #('Borm-Editor').
			spec group: 'default' with: #('plugin' 'OpenPonk') ]
