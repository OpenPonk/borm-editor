Class {
	#name : 'BormAssociationShape',
	#superclass : 'OPEdge',
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
}

{ #category : 'constants' }
BormAssociationShape >> marker [

	^ self subclassResponsibility
]

{ #category : 'rendering' }
BormAssociationShape >> renderBasicShape [

	^ OPRSPolyline new
		  markerEnd: self marker;
		  withBorderAttachPoint;
		  controlPointsController: OPRSDraggableCPController new;
		  addInteraction: OPRSDraggableControlPoints;
		  color: Color black;
		  from: self source roassalShape;
		  to: self target roassalShape;
		  yourself
]
