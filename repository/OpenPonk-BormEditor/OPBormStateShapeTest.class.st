Class {
	#name : #OPBormStateShapeTest,
	#superclass : #OPBormShapeTest,
	#category : #'OpenPonk-BormEditor-Tests'
}

{ #category : #accessing }
OPBormStateShapeTest >> diagramElementClass [
	^ BormStateShape
]

{ #category : #'as yet unclassified' }
OPBormStateShapeTest >> testAdd [

	diagramElement modelElement: BormState new.
	diagramElement renderBasicShapeIn: canvas.
	self
		assertCollection: canvas nodes asSet
		equals:
			({ diagramElement } asSet , diagramElement ownedElements collect:
				 #roassalShape)
]

{ #category : #'as yet unclassified' }
OPBormStateShapeTest >> testRemove [
	diagramElement modelElement: BormState new.
	self assert: canvas nodes isEmpty.
	diagramElement renderBasicShapeIn: canvas.
	self assert: canvas nodes isNotEmpty.
	diagramElement remove.
	self assert: canvas nodes isEmpty.
]

{ #category : #'as yet unclassified' }
OPBormStateShapeTest >> testRemove1 [

	diagramElement modelElement: (BormState new
			 beInitial;
			 beFinal).
	self assert: canvas nodes isEmpty.
	diagramElement renderBasicShapeIn: canvas.
	self assert: canvas nodes isNotEmpty.
	diagramElement remove.
	self assert: canvas nodes isEmpty
]
