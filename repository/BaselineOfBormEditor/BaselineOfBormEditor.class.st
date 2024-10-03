Class {
	#name : 'BaselineOfBormEditor',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBormEditor',
	#package : 'BaselineOfBormEditor'
}

{ #category : 'baselines' }
BaselineOfBormEditor >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'BormModel'
			with: [ spec repository: 'github://openponk/borm-model:v4.0.x' ].
		spec
			baseline: 'OpenPonk'
			with: [ spec repository: 'github://openponk/openponk:v4.0.x' ].
		spec baseline: 'PetitParser' with: [
			spec
				repository: 'github://moosetechnology/PetitParser:v3.0.x';
				loads:
					#( 'Core' 'Tests' 'Examples' 'Islands' 'Analyzer' 'Preprocessor'
					   'Indent' 'Extension' 'TestsExtension' 'Parser' ) ].

		spec
			package: 'OpenPonk-BormEditor'
			with: [ spec requires: #( 'PetitParser' 'BormModel' ) ].
		spec group: 'plugin' with: #( 'OpenPonk-BormEditor' ).
		spec group: 'default' with: #( 'OpenPonk' 'plugin' ) ]
]
