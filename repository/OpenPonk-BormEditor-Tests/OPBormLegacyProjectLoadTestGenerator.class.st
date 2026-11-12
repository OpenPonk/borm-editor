"
I am a testing utility responsible for generating backward-compatibility test payloads specifically for legacy BORM projects.
"
Class {
	#name : 'OPBormLegacyProjectLoadTestGenerator',
	#superclass : 'OPLegacyProjectLoadTestGenerator',
	#category : 'OpenPonk-BormEditor-Tests-Examples',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Examples'
}

{ #category : 'hooks' }
OPBormLegacyProjectLoadTestGenerator >> model [

	^ OPBormExamples examplePizzaDelivery
]
