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
OPBormStateShapeTest >> testFinalShape [

	| borderedShapesCounter originalCount |
	borderedShapesCounter := [
	                         canvas shapes count: [ :each |
		                         each hasBorder and: [
			                         each borderColor isTransparent not ] ] ].

	shape modelElement: BormState new.
	shape renderIn: canvas.
	originalCount := borderedShapesCounter value.

	shape modelElement isFinal: true.
	shape modelChanged.
	self assert: borderedShapesCounter value > originalCount.

	shape modelElement isFinal: false.
	shape modelChanged.
	self assert: borderedShapesCounter value equals: originalCount
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
