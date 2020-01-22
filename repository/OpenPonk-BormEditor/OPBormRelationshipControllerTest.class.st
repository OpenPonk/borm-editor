Class {
	#name : #OPBormRelationshipControllerTest,
	#superclass : #OPBormControllerTest,
	#instVars : [
		'sourceController',
		'targetController'
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
	sourceController := self sourceControllerClass new.
	sourceController createModelIn: diagramController model.
	targetController := self targetControllerClass new.
	targetController createModelIn: diagramController model.
	controller source: sourceController.
	controller target: targetController
]

{ #category : #'as yet unclassified' }
OPBormRelationshipControllerTest >> sourceControllerClass [
	^ OPBormActivityController
]

{ #category : #'as yet unclassified' }
OPBormRelationshipControllerTest >> targetControllerClass [
	^ self subclassResponsibility
]
