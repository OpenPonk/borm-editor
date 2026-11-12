"
I am an abstract base test class verifying the common interaction, connectivity, and canvas targeting rules shared by BORM process node controllers (States and Activities).
"
Class {
	#name : 'OPBormProcessNodeControllerTest',
	#superclass : 'OPBormElementControllerTest',
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'testing' }
OPBormProcessNodeControllerTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self = OPBormProcessNodeControllerTest
]
