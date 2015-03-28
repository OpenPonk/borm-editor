accessing
baseline: spec
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BormModel' with: [
				spec
					repository: 'github://dynacase/borm-model/repository' ].
		spec
			baseline: 'DynaCASE' with: [ 
				spec
					repository: 'github://dynacase/dynacase/repository' ].
		spec
			baseline: 'PetitParser' with: [ 
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'minimal';
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ].
		spec 
			package: 'Borm-Editor' with: [
				spec requires: #('BormModel' 'DynaCASE' 'PetitParser' ). ].
		spec group: 'default' with: #('Borm-Editor' ). ]
