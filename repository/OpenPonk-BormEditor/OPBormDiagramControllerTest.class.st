Class {
	#name : 'OPBormDiagramControllerTest',
	#superclass : 'OPAbstractDiagramControllerTest',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
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
	self assert: controller controllerFactory isNotNil.
	self assert: (controller controllerFactory isKindOf: OPControllerFactory)
]

{ #category : 'tests' }
OPBormDiagramControllerTest >> testInitializePalette [
	| palette |
	palette := OPPalette new.
	controller initializePalette: palette.
	self denyCollection: palette items hasSameElements: #()
]
