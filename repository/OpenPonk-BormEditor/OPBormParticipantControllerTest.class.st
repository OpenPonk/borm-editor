"
I am a unit test class verifying the behavior of OPBormParticipantController, focusing on its role as a container, diagram hooks, and figure rendering tasks.
"
Class {
	#name : 'OPBormParticipantControllerTest',
	#superclass : 'OPBormContainerControllerTest',
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'constants' }
OPBormParticipantControllerTest class >> diagramElementClass [

	^ BormParticipantShape
]

{ #category : 'constants' }
OPBormParticipantControllerTest >> controllerClass [
	^ OPBormParticipantController
]

{ #category : 'accessing' }
OPBormParticipantControllerTest >> createTargetController [
	^ diagramController
]

{ #category : 'constants' }
OPBormParticipantControllerTest >> creationTargetControllerClass [
	^ self diagramControllerClass
]

{ #category : 'constants' }
OPBormParticipantControllerTest >> creationTargetModelClass [
	^ self diagramModelClass
]

{ #category : 'constants' }
OPBormParticipantControllerTest >> modelClass [
	^ BormParticipant
]

{ #category : 'tests' }
OPBormParticipantControllerTest >> testNameChangeMaintainsLabelLeftPosition [
	| label initialLeft newLeft |
	controller createModelIn: diagramController model.
	diagramController addController: controller.
	controller
		createDiagramElement;
		renderDiagramElement.

	controller model name: 'A'.
	controller modelChanged.
	label := controller roassalShape propertyAt: #RSLabeled.
	initialLeft := label encompassingRectangle left.

	controller model name: 'A Much Longer Participant Name That Expands'.
	controller modelChanged.
	label := controller roassalShape propertyAt: #RSLabeled.
	newLeft := label encompassingRectangle left.

	self assert: (newLeft closeTo: initialLeft absolutePrecision: 0.5)
]
