"
Verifies the serialization and deserialization roundtrip persistence for BORM process models.
"
Class {
	#name : 'OPBormPluginRoundtripTest',
	#superclass : 'OPAbstractPluginExampleRoundtripTest',
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPBormPluginRoundtripTest class >> pluginClass [
	^ OPBormPlugin
]
