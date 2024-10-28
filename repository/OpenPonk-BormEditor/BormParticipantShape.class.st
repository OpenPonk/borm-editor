Class {
	#name : 'BormParticipantShape',
	#superclass : 'OPBoundNode',
	#instVars : [
		'innerRoassalShapesBlock',
		'icon'
	],
	#category : 'OpenPonk-BormEditor-Shapes',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Shapes'
}

{ #category : 'printing' }
BormParticipantShape class >> typeIconFor: aType [

	aType = BormParticipantType Person ifTrue: [ 
		^ OPBormEditorIcons personIcon ].
	aType = BormParticipantType System ifTrue: [ 
		^ OPBormEditorIcons bormSystemIcon ].
	aType = BormParticipantType Organization ifTrue: [ 
		^ OPBormEditorIcons organizationIcon ].
	^ nil
]

{ #category : 'rendering' }
BormParticipantShape >> addSelectionDraggableInteraction [

	roassalShape
	@ (OPRSSelectionDraggable thatAlsoDragsShapesProvidedByBlock:
			 innerRoassalShapesBlock)
]

{ #category : 'initialization' }
BormParticipantShape >> initialize [

	super initialize.
	innerRoassalShapesBlock := [ :allNodes | allNodes ]
]

{ #category : 'initialization' }
BormParticipantShape >> innerRoassalShapesBlock: aBlock [

	innerRoassalShapesBlock := aBlock
]

{ #category : 'removing' }
BormParticipantShape >> removeRender [

	super removeRender.
	icon := nil
]

{ #category : 'rendering' }
BormParticipantShape >> renderBasicShape [

	^ RSBox new
		  width: 200;
		  height: 300;
		  color: (Color fromHexString: 'bce2fe');
		  cornerRadius: 2;
		  borderColor: Color black;
		  yourself
]

{ #category : 'rendering' }
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
		        form: self typeIcon;
		        yourself.
	RSLocation new
		top;
		right;
		offset: -5 @ 5;
		stick: icon on: self roassalShape.
	self canvas add: icon.
	roassalShape when: RSShapeRemovedEvent do: [ icon remove ] for: self
]

{ #category : 'rendering' }
BormParticipantShape >> selectableInteraction [

	^ OPRSSelectable highlightBorderColorBlue
]

{ #category : 'rendering' }
BormParticipantShape >> shouldBePositionableByUser [

	^ true
]

{ #category : 'interactions' }
BormParticipantShape >> shouldBeResizableByUser [

	^ true
]

{ #category : 'rendering' }
BormParticipantShape >> typeIcon [

	^ self typeIconFor: self modelElement type
]

{ #category : 'rendering' }
BormParticipantShape >> typeIconFor: aType [

	^ self class typeIconFor: aType
]

{ #category : 'rendering' }
BormParticipantShape >> updateRenderFromModel [

	(roassalShape propertyAt: #RSLabeled) text: self modelElement name.
	icon form: self typeIcon.
	super updateRenderFromModel.
	roassalShape signalUpdate
]
