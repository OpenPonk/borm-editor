Class {
	#name : #BaselineOfBormEditor,
	#superclass : #BaselineOf,
	#category : #BaselineOfBormEditor
}

{ #category : #baselines }
BaselineOfBormEditor >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'BormModel'
			with: [ spec repository: 'github://openponk/borm-model' ].
		spec
			baseline: 'OpenPonk'
			with: [ spec repository: 'github://openponk/openponk' ].
		spec baseline: 'PetitParser' with: [
			spec
				repository: 'github://moosetechnology/PetitParser:v3.x.x/src';
				loads:
					#( 'Core' 'Tests' 'Examples' 'Islands' 'Analyzer' 'Preprocessor'
					   'Indent' 'Extension' 'TestsExtension' 'Parser' ) ].

		spec baseline: 'XPath' with: [
			spec
				repository: 'github://pharo-contributions/XML-XPath:c063098';
				loads: #( Core ) ].
		spec
			package: 'OpenPonk-BormEditor'
			with: [ spec requires: #( 'PetitParser' 'XPath' 'BormModel' ) ].
		spec group: 'plugin' with: #( 'OpenPonk-BormEditor' ).
		spec group: 'default' with: #( 'OpenPonk' 'plugin' ) ]
]
