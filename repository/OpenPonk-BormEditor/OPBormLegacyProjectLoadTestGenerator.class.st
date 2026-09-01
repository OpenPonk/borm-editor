"
I am a testing utility responsible for generating backward-compatibility test payloads specifically for legacy BORM projects.
"
Class {
	#name : 'OPBormLegacyProjectLoadTestGenerator',
	#superclass : 'OPLegacyProjectLoadTestGenerator',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'hooks' }
OPBormLegacyProjectLoadTestGenerator >> model [

	^ OPBormExampleDiagrams examplePizzaDelivery
]
