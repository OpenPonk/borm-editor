Class {
	#name : #BormParticipantShape,
	#superclass : #BormShape,
	#instVars : [
		'innerRoassalShapesBlock',
		'typeIconProvider',
		'iconElement',
		'labelConstraint',
		'iconConstraint'
	],
	#category : #'OpenPonk-BormEditor-Visuals'
}

{ #category : #hooks }
BormParticipantShape >> createContainerFigure [
	^ (RTRoundedBox new
		width: 200;
		height: 300;
		color: (Color fromHexString: 'bce2fe');
		borderRadius: 2;
		borderColor: Color black) elementOn: ''
]

{ #category : #initialization }
BormParticipantShape >> initialize [

	super initialize.
	innerRoassalShapesBlock := [ :allNodes | allNodes ]
]

{ #category : #initialization }
BormParticipantShape >> innerRoassalShapesBlock: aBlock [

	innerRoassalShapesBlock := aBlock
]

{ #category : #hooks }
BormParticipantShape >> refreshFigure [
	(figure attributeAt: #RTLabelledLabel) text: self model name.
	labelConstraint move.
	figure trachelShape pushBack.
	iconElement trachelShape form: self typeIconForModel.
	iconConstraint move.
	self diagramController view signalUpdate.
	^ self figure
]

{ #category : #rendering }
BormParticipantShape >> renderShapeDetails [

	self roassalShape
		@ OPRSSelectable;
		@ (OPRSSelectionDraggable thatAlsoDragsShapesProvidedByBlock:
					 innerRoassalShapesBlock);
		@ OPRSResizable
]

{ #category : #hooks }
BormParticipantShape >> typeIconForModel [

	^ typeIconProvider typeIconFor: self model type
]

{ #category : #accessing }
BormParticipantShape >> typeIconProvider: anObject [

	typeIconProvider := anObject
]

{ #category : #hooks }
BormParticipantShape >> updateRenderFromModel [

	(self roassalShape attributeAt: #RTLabelledLabel) text:
		self model name.
	labelConstraint move.
	self roassalShape trachelShape pushBack.
	iconElement trachelShape form: self typeIconForModel.
	iconConstraint move.
	self diagramController view signalUpdate.
	^ self figure
]
