Class {
	#name : #OPBormStateShapeTest,
	#superclass : #OPAbstractShapeTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #hooks }
OPBormStateShapeTest >> shapeClass [
	^ BormStateShape
]

{ #category : #tests }
OPBormStateShapeTest >> testAdd [

	shape modelElement: BormState new.
	shape renderBasicShapeIn: canvas.
	self
		assertCollection: canvas nodes asSet
		equals:
			({ shape } asSet , shape ownedElements collect:
				 #roassalShape)
]

{ #category : #tests }
OPBormStateShapeTest >> testRemove [
	shape modelElement: BormState new.
	self assert: canvas nodes isEmpty.
	shape renderBasicShapeIn: canvas.
	self assert: canvas nodes isNotEmpty.
	shape remove.
	self assert: canvas nodes isEmpty.
]

{ #category : #tests }
OPBormStateShapeTest >> testRemove1 [

	shape modelElement: (BormState new
			 beInitial;
			 beFinal).
	self assert: canvas nodes isEmpty.
	shape renderBasicShapeIn: canvas.
	self assert: canvas nodes isNotEmpty.
	shape remove.
	self assert: canvas nodes isEmpty
]
