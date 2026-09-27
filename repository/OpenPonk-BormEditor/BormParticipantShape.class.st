"
I render a BORM Participant as a Roassal bound node. I manage the participant's boundary, background, inner nested shapes (process nodes), and dynamic type icons.
"
Class {
	#name : 'BormParticipantShape',
	#superclass : 'OPBoundNode',
	#instVars : [
		'icon',
		'labeled'
	],
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
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

{ #category : 'layout' }
BormParticipantShape >> adaptBoundsToInnerBounds: anInnerRectangle [
	"Adapts participant shape extent and position with standard BORM margins."
	| newBounds |
	newBounds := anInnerRectangle expandBy: 40 @ 30.
	self roassalShape
		extent: newBounds extent;
		translateTo: newBounds center
]

{ #category : 'interactions' }
BormParticipantShape >> addSelectionDraggableInteraction [
	roassalShape @ (OPRSSelectionDraggable thatAlsoDragsShapesProvidedByBlock: [ self innerDraggableRoassalShapes ])
]

{ #category : 'accessing' }
BormParticipantShape >> attachedShapes [

	^ super attachedShapes , { icon }
]

{ #category : 'testing' }
BormParticipantShape >> isContainer [
	^ true
]

{ #category : 'removing' }
BormParticipantShape >> removeRender [
	super removeRender.
	icon := nil.
	labeled := nil
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
	self canvas add: icon
]

{ #category : 'interactions' }
BormParticipantShape >> selectableInteraction [

	^ OPRSSelectable highlightBorderColorBlue
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
	| label |
	label := roassalShape propertyAt: #RSLabeled.
	label text: (self modelElement name ifNil: [ '' ]).
	labeled location move: label on: roassalShape.
	icon form: self typeIcon.
	super updateRenderFromModel.
	roassalShape signalUpdate
]
