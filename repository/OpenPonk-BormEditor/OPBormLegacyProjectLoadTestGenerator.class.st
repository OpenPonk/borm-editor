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
