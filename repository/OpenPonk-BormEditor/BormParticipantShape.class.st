Class {
	#name : #BormParticipantShape,
	#superclass : #OPBoundNode,
	#instVars : [
		'innerRoassalShapesBlock',
		'typeIconProvider',
		'icon'
	],
	#category : #'OpenPonk-BormEditor-Shapes'
}

{ #category : #rendering }
BormParticipantShape >> addSelectionDraggableInteraction [

	roassalShape
	@ (OPRSSelectionDraggable thatAlsoDragsShapesProvidedByBlock:
			 innerRoassalShapesBlock)
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
BormParticipantShape >> renderBasicShape [

	^ RSBox new
		  width: 200;
		  height: 300;
		  color: (Color fromHexString: 'bce2fe');
		  cornerRadius: 2;
		  borderColor: Color black;
		  yourself
]

{ #category : #rendering }
BormParticipantShape >> renderShapeDetails [

	| labeled |
	labeled := OPRSLabeled new.
	labeled color: Color black.
	labeled location
		inner;
		left;
		top;
		offset: 5 @ 5.
	roassalShape @ labeled.

	icon := RSBitmap new
		        form: typeIconProvider typeIcon;
		        yourself.
	RSLocation new
		top;
		right;
		offset: -5 @ 5;
		stick: icon on: self roassalShape.
	self canvas add: icon.
	roassalShape when: RSShapeRemovedEvent do: [ icon remove ] for: self
]

{ #category : #rendering }
BormParticipantShape >> selectableInteraction [

	^ OPRSSelectable highlightBorderColorBlue
]

{ #category : #rendering }
BormParticipantShape >> shouldBePositionableByUser [

	^ true
]

{ #category : #interactions }
BormParticipantShape >> shouldBeResizableByUser [

	^ true
]

{ #category : #accessing }
BormParticipantShape >> typeIconProvider: anObject [

	typeIconProvider := anObject
]

{ #category : #hooks }
BormParticipantShape >> updateRenderFromModel [

	(roassalShape propertyAt: #RSLabeled) text: self modelElement name.
	icon form: typeIconProvider typeIcon.
	super updateRenderFromModel.
	roassalShape signalUpdate
]
