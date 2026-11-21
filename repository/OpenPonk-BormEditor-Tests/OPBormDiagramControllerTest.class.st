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

	| palette entries expectedToolClasses |
	palette := OPPalette new.
	controller initializePalette: palette.
	entries := palette items select: [ :eachItem | eachItem class == OPPaletteEntry ].
	expectedToolClasses := {
		                       ('Participant' -> OPBormParticipantController).
		                       ('State' -> OPBormStateController).
		                       ('Activity' -> OPBormActivityController).
		                       ('Transition' -> OPBormTransitionController).
		                       ('Communication' -> OPBormCommunicationController).
		                       ('Data Flow' -> OPBormDataFlowController).
		                       ('Constraint' -> OPBormConstraintController) }.
	self assert: (entries collect: #label as: Array) equals: { 'Select' } , (expectedToolClasses collect: #key).
	expectedToolClasses do: [ :eachPair |
			| entry createdController |
			entry := entries detect: [ :eachEntry | eachEntry label = eachPair key ].
			entry performAction.
			createdController := palette selectedTool instVarNamed: #controller.
			self assert: createdController class identicalTo: eachPair value ]
]
