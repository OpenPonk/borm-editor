"
Tests diagram-level controller operations, participant placement, and activity flows in BORM diagrams.
"
Class {
	#name : 'OPBormDiagramControllerTest',
	#superclass : 'OPAbstractDiagramControllerTest',
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPBormDiagramControllerTest >> controllerClass [
	^ OPBormDiagramController
]

{ #category : 'accessing' }
OPBormDiagramControllerTest >> diagramModelClass [
	^ BormORModel
]

{ #category : 'accessing' }
OPBormDiagramControllerTest >> modelClass [
	^ BormORModel
]

{ #category : 'tests' }
OPBormDiagramControllerTest >> testControllerFactory [

	self deny: controller controllerFactory identicalTo: nil.
	self assert: controller controllerFactory class equals: OPControllerFactory
]

{ #category : 'tests' }
OPBormDiagramControllerTest >> testInitializePalette [
	| palette |
	palette := OPPalette new.
	controller initializePalette: palette.
	self denyCollection: palette items hasSameElements: #()
]
