Class {
	#name : #BormCommunicationController,
	#superclass : #BormRelationshipController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #adding }
BormCommunicationController >> addAsTargetFor: aController [
	self assert: (self canBeTargetFor: aController).
	(self canBeTargetForDataFlow: aController)
		ifTrue: [ self addAsTargetForDataFlow: aController ].
	(self canBeTargetForConstraint: aController)
		ifTrue: [ self addAsTargetForConstraint: aController ]
]

{ #category : #adding }
BormCommunicationController >> addAsTargetForConstraint: aConstraintController [
	self assert: (self canBeTargetForConstraint: aConstraintController).
	self model constraint: aConstraintController loadModel.
	aConstraintController attachTo: self diagramController
]

{ #category : #adding }
BormCommunicationController >> addAsTargetForDataFlow: aDataFlowController [
	| newDataFlow |
	self assert: (self canBeTargetForDataFlow: aDataFlowController).
	aDataFlowController diagramController: self diagramController.
	newDataFlow := aDataFlowController createModel.
	self model addDataFlow: newDataFlow.
	aDataFlowController model: newDataFlow.
	self diagramController controllers add: aDataFlowController.
	aDataFlowController attach
]

{ #category : #accessing }
BormCommunicationController >> allOwnedElementsInModel [
	^ super allOwnedElementsInModel , model dataFlows
]

{ #category : #testing }
BormCommunicationController >> canBeTargetFor: aController [
	^ (self canBeTargetForDataFlow: aController)
		or: [ self canBeTargetForConstraint: aController ]
]

{ #category : #testing }
BormCommunicationController >> canBeTargetForConstraint: aController [
	^ self model hasConstraint not and: [ aController isKindOf: BormConstraintController ]
]

{ #category : #testing }
BormCommunicationController >> canBeTargetForDataFlow: aController [
	^ aController isKindOf: BormDataFlowController
]

{ #category : #hooks }
BormCommunicationController >> connectionFeedback [
	^ OPInteractiveLine new
		lineBuilder: [ :fromFigure :toFigure | 
			OPRTStyledConnection new
				decorate: [ :deco | deco arrowHead ];
				withBorderAttachPoint;
				color: Color darkGray muchDarker;
				edgeFrom: fromFigure to: toFigure ];
		from: source figure
]

{ #category : #hooks }
BormCommunicationController >> createEdgeFrom: fromElement to: toElement [
	| edge |
	edge := OPRTStyledConnection new
		withBorderAttachPoint;
		color: Color black;
		edgeFrom: fromElement to: toElement.
	edge shape decorations arrowHead.
	^ edge
]

{ #category : #accessing }
BormCommunicationController >> createModel [
	| communication |
	self model ifNotNil: [ ^ self model ].
	communication := super createModel.
	source model send: communication.
	target model receive: communication.
	^ communication
]

{ #category : #accessing }
BormCommunicationController >> modelClass [
	^ BormCommunication
]

{ #category : #destruction }
BormCommunicationController >> removeModel [
	self model target removeCommunication: self model.
	self model source removeCommunication: self model
]
