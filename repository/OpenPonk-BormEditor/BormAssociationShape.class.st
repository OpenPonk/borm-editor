Class {
	#name : 'BormAssociationShape',
	#superclass : 'OPEdge',
	#category : 'OpenPonk-BormEditor-Shapes',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Shapes'
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
