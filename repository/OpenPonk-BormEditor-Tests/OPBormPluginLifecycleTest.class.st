"
Verifies the initialization, registration, and shutdown lifecycle of the BORM plugin.
"
Class {
	#name : 'OPBormPluginLifecycleTest',
	#superclass : 'OPAbstractPluginExampleLifecycleTest',
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPBormPluginLifecycleTest class >> pluginClass [
	"Answers the OPPlugin class under test."
	^ OPBormPlugin
]
