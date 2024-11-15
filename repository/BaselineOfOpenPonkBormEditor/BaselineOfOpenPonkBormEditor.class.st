Class {
	#name : 'BaselineOfOpenPonkBormEditor',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfOpenPonkBormEditor',
	#package : 'BaselineOfOpenPonkBormEditor'
}

{ #category : 'baselines' }
BaselineOfOpenPonkBormEditor >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'OpenPonkBormModel'
			with: [ spec repository: 'github://openponk/borm-model' ].
		spec
			baseline: 'OpenPonk'
			with: [ spec repository: 'github://openponk/openponk' ].
		spec baseline: 'PetitParser' with: [
			spec
				repository: 'github://moosetechnology/PetitParser:v3.0.x';
				loads:
					#( 'Core' 'Tests' 'Examples' 'Islands' 'Analyzer' 'Preprocessor'
					   'Indent' 'Extension' 'TestsExtension' 'Parser' ) ].

		spec
			package: 'OpenPonk-BormEditor'
			with: [ spec requires: #( 'PetitParser' 'OpenPonkBormModel' ) ].
		spec group: 'plugin' with: #( 'OpenPonk-BormEditor' ).
		spec group: 'default' with: #( 'OpenPonk' 'plugin' ) ]
]
