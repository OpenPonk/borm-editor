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
			package: 'Borm-Editor' with: [
				spec requires: #('BormModel' 'DynaCASE' ). ].
		spec group: 'default' with: #('Borm-Editor' ). ]
