Class {
	#name : #BaselineOfBormEditor,
	#superclass : #BaselineOf,
	#category : #BaselineOfBormEditor
}

{ #category : #accessing }
BaselineOfBormEditor >> baseline: spec [
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
						repository: 'github://pharo-contributions/XML-XMLParser:3.5.x/src';
						loads: #(Core) ].
			spec
				baseline: 'XPath'
				with:
					[ spec repository: 'github://pharo-contributions/XML-XPath:2.2.0/src' ].
			spec
				package: 'OpenPonk-BormEditor'
				with: [ spec requires: #('XPath' 'XMLParser' 'BormModel') ].
			spec group: 'plugin' with: #('OpenPonk-BormEditor').
			spec group: 'default' with: #('OpenPonk' 'plugin') ]
]

{ #category : #accessing }
BaselineOfBormEditor >> loadPetitParser [
	"this is solved separatedly by direct loading code because PetitParser does not specify Roassal2 version, which causes conflicts and this is probably only way to use onConflict:"

	Metacello new
		baseline: 'PetitParser';
		repository: 'github://moosetechnology/PetitParser:v2.x.x/src';
		onConflict: [ :err | err useLoaded ];
		load
]
