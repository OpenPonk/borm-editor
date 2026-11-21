"
I am a unit test class verifying the visual rendering, containment logic, and boundary updates (such as initial/final indicators) of BORM State shapes.
"
Class {
	#name : 'OPBormStateShapeTest',
	#superclass : 'OPAbstractNodeTest',
	#category : 'OpenPonk-BormEditor-Tests-DiagramElements',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'DiagramElements'
}

{ #category : 'instance creation' }
OPBormStateShapeTest >> modelClass [

	^ BormState 
]

{ #category : 'hooks' }
OPBormStateShapeTest >> shapeClass [
	^ BormStateShape
]

{ #category : 'tests' }
OPBormStateShapeTest >> testAdd [

	shape modelElement: BormState new.
	shape renderBasicShapeIn: canvas.
	self
		assertCollection: canvas nodes asSet
		equals:
			({ shape } asSet , shape ownedElements collect:
				 #roassalShape)
]

{ #category : 'tests' }
OPBormStateShapeTest >> testExtentChangeAndLongTextExpandsHeight [

	| state initialHeight |
	state := BormState named: 'Short'.
	shape modelElement: state.
	shape renderIn: canvas.
	initialHeight := shape roassalShape height.

	state name:
		'A very long BORM state name that wraps across many lines when the shape is narrowed significantly to trigger vertical expansion'.
	shape roassalShape
		extent: 40 @ initialHeight;
		extent: 38 @ initialHeight.

	self
		assert: shape roassalShape height > initialHeight
		description: 'Narrowing shape width with long text must re-wrap and expand shape height'
]

{ #category : 'tests' }
OPBormStateShapeTest >> testFinalShape [

	| borderedShapesCounter originalCount |
	borderedShapesCounter := [ canvas shapes count: [ :each | each hasBorder and: [ each borderColor isTransparent not ] ] ].

	shape modelElement: BormState new.
	shape renderIn: canvas.
	originalCount := borderedShapesCounter value.

	shape modelElement isFinal: true.
	shape modelChanged.
	self assert: borderedShapesCounter value equals: originalCount + 1.

	shape modelElement isFinal: false.
	shape modelChanged.
	self assert: borderedShapesCounter value equals: originalCount
]

{ #category : 'tests' }
OPBormStateShapeTest >> testInitialToggleRemovesPlayIconAndTextMetrics [

	| detachedShape state playIcon |
	detachedShape := BormStateShape new.
	self assert: detachedShape textOffset equals: 0 @ 0.
	self assert: detachedShape textPadding equals: 5.

	state := BormState new
		         beInitial;
		         beFinal;
		         yourself.
	shape modelElement: state.
	self assert: shape textOffset equals: -10 @ 0.
	self assert: shape textPadding equals: 19.

	shape renderIn: canvas.
	playIcon := shape instVarNamed: #playIcon.
	self assert: playIcon isInACanvas description: 'Play icon must be on canvas for an initial state'.

	state isInitial: false.
	shape modelChanged.
	self deny: playIcon isInACanvas description: 'Play icon must be removed from canvas when state is no longer initial'
]

{ #category : 'tests' }
OPBormStateShapeTest >> testRemove [

	shape modelElement: BormState new.
	self assertEmpty: canvas nodes.
	shape renderBasicShapeIn: canvas.
	self denyEmpty: canvas nodes.
	shape remove.
	self assertEmpty: canvas nodes
]

{ #category : 'tests' }
OPBormStateShapeTest >> testRemove1 [

	shape modelElement: (BormState new
			 beInitial;
			 beFinal).
	self assertEmpty: canvas nodes.
	shape renderBasicShapeIn: canvas.
	self denyEmpty: canvas nodes.
	shape remove.
	self assertEmpty: canvas nodes
]

{ #category : 'tests' }
OPBormStateShapeTest >> testSubmodelTogglesPlusIconOnCanvas [

	| state plusIcon |
	state := BormState named: 'WithSubmodel'.
	shape modelElement: state.
	shape renderIn: canvas.
	plusIcon := shape instVarNamed: #plusIcon.
	self deny: plusIcon isInACanvas description: 'Plus icon must not be on canvas when submodel is nil'.

	state submodel: (BormORModel named: 'Sub').
	shape modelChanged.
	self assert: plusIcon isInACanvas description: 'Plus icon must be added to canvas when submodel is set'.

	state submodel: nil.
	shape modelChanged.
	self deny: plusIcon isInACanvas description: 'Plus icon must be removed from canvas when submodel is cleared'
]
