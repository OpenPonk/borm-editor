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
		spec baseline: 'XMLParser' with: [
			spec
				repository: 'github://pharo-contributions/XML-XMLParser:4f9cb10';
				loads: #( Core ) ].
		spec baseline: 'XPath' with: [
			spec
				repository: 'github://pharo-contributions/XML-XPath:c063098';
				loads: #( Core ) ].
		spec
			package: 'OpenPonk-BormEditor'
			with: [ spec requires: #( 'XPath' 'XMLParser' 'BormModel' ) ].
		spec group: 'plugin' with: #( 'OpenPonk-BormEditor' ).
		spec group: 'default' with: #( 'OpenPonk' 'plugin' ) ]
]
