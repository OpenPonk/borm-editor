Class {
	#name : #BaselineOfBormEditor,
	#superclass : #BaselineOf,
	#category : #BaselineOfBormEditor
}

{ #category : #accessing }
BaselineOfBormEditor >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'BormModel'
			with: [ spec repository: 'github://openponk/borm-model/repository' ].
		spec
			baseline: 'OpenPonk'
			with: [ spec repository: 'github://openponk/openponk:dev-roassal3' ].
		spec baseline: 'XMLParser' with: [ 
			spec
				repository: 'github://pharo-contributions/XML-XMLParser:3.5.x/src';
				loads: #( Core ) ].
		spec baseline: 'XPath' with: [ 
			spec
				repository: 'github://pharo-contributions/XML-XPath:3450f91/src';
				loads: #( Core ) ].
		spec
			package: 'OpenPonk-BormEditor'
			with: [ spec requires: #( 'XPath' 'XMLParser' 'BormModel' ) ].
		spec group: 'plugin' with: #( 'OpenPonk-BormEditor' ).
		spec group: 'default' with: #( 'OpenPonk' 'plugin' ) ]
]
