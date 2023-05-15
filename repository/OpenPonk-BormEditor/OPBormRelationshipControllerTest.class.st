Class {
	#name : #OPBormRelationshipControllerTest,
	#superclass : #OPBormControllerTest,
	#instVars : [
		'sourceController'
	],
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #testing }
OPBormRelationshipControllerTest class >> isAbstract [
	^ self = OPBormRelationshipControllerTest
]

{ #category : #running }
OPBormRelationshipControllerTest >> setUp [
	super setUp.
	self setUpSource.
	controller source: sourceController.
	controller target: relationshipController
]

{ #category : #running }
OPBormRelationshipControllerTest >> setUpSource [
	sourceController := self sourceControllerClass new.
	sourceController diagramController: diagramController.
	sourceController createModelIn: diagramController model
]

{ #category : #'as yet unclassified' }
OPBormRelationshipControllerTest >> sourceControllerClass [
	^ OPBormActivityController
]
