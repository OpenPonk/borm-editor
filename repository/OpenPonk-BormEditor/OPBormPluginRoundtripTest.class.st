"
Verifies the serialization and deserialization roundtrip persistence for BORM process models.
"
Class {
	#name : 'OPBormPluginRoundtripTest',
	#superclass : 'OPAbstractPluginExampleRoundtripTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPBormPluginRoundtripTest class >> pluginClass [
	^ OPBormPlugin
]
