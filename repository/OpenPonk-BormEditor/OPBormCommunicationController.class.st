Class {
	#name : #OPBormCommunicationController,
	#superclass : #OPBormRelationshipController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #adding }
OPBormCommunicationController >> addAsTargetFor: aController [
	^ aController visitTarget: self
]

{ #category : #adding }
OPBormCommunicationController >> addAsTargetForConstraint: aConstraintController [
	self assert: (self canBeTargetForConstraint: aConstraintController).
	^ super addAsTargetFor: aConstraintController
]

{ #category : #adding }
OPBormCommunicationController >> addAsTargetForDataFlow: aDataFlowController [
	self assert: (self canBeTargetForDataFlow: aDataFlowController).
	^ super addAsTargetFor: aDataFlowController
]

{ #category : #testing }
OPBormCommunicationController >> canBeTargetFor: aController [
	^ (aController respondsTo: #canVisitTarget:)
		and: [ aController canVisitTarget: self ]
]

{ #category : #testing }
OPBormCommunicationController >> canBeTargetForConstraint: aController [
	^ self model hasConstraint not
]

{ #category : #testing }
OPBormCommunicationController >> canBeTargetForDataFlow: aController [
	^ true
]

{ #category : #hooks }
OPBormCommunicationController >> connectionFeedback [
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
OPBormCommunicationController >> createEdgeFrom: fromElement to: toElement [
	| edge |
	edge := OPRTStyledConnection new
		withBorderAttachPoint;
		color: Color black;
		edgeFrom: fromElement to: toElement.
	edge shape decorations arrowHead.
	^ edge
]

{ #category : #accessing }
OPBormCommunicationController >> createModelIn: aParentModel [
	self model: self modelClass new.
	model source: self source model.
	model target: self target model.
	source model send: model.
	target model receive: model.
	^ model
]

{ #category : #accessing }
OPBormCommunicationController >> elementsToShowInside [
	^ super elementsToShowInside , model dataFlows
]

{ #category : #accessing }
OPBormCommunicationController >> modelClass [
	^ BormCommunication
]

{ #category : #destruction }
OPBormCommunicationController >> removeController [
	"self model dataFlows ifNotEmpty: [ self halt ]."
	super removeController
]

{ #category : #destruction }
OPBormCommunicationController >> removeModel [
	self model target removeCommunication: self model.
	self model source removeCommunication: self model
]
