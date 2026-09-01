"
I am an integration test class verifying that the BORM Pizza Delivery example model survives roundtrip serialization (save and load) without data loss or corruption.
"
Class {
	#name : 'OPBormPizzaDeliveryExamplePersistenceTest',
	#superclass : 'OPExamplePersistenceTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'hooks' }
OPBormPizzaDeliveryExamplePersistenceTest >> createExampleModel [

	^ OPBormExampleDiagrams examplePizzaDelivery
]
