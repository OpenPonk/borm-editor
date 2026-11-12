"
I am an integration test class verifying that the BORM Pizza Delivery example model survives roundtrip serialization (save and load) without data loss or corruption.
"
Class {
	#name : 'OPBormPizzaDeliveryExamplePersistenceTest',
	#superclass : 'OPExamplePersistenceTest',
	#category : 'OpenPonk-BormEditor-Tests-Examples',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Examples'
}

{ #category : 'hooks' }
OPBormPizzaDeliveryExamplePersistenceTest >> createExampleModel [

	^ OPBormExamples examplePizzaDelivery
]
