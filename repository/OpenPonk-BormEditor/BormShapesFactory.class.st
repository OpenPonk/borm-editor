Class {
	#name : 'BormShapesFactory',
	#superclass : 'Object',
	#category : 'OpenPonk-BormEditor-Shapes',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Shapes'
}

{ #category : 'as yet unclassified' }
BormShapesFactory >> backgroundColor [
	^ Color white
]

{ #category : 'as yet unclassified' }
BormShapesFactory >> borderColor [
	^ Color black
]

{ #category : 'as yet unclassified' }
BormShapesFactory >> newBox [

	^ RSBox new
		  color: self backgroundColor;
		  borderColor: self borderColor;
		  yourself
]

{ #category : 'as yet unclassified' }
BormShapesFactory >> newRoundedBox [

	^ RSBox new
		  color: self backgroundColor;
		  borderColor: self borderColor;
		  cornerRadius: 20;
		  yourself
]

{ #category : 'as yet unclassified' }
BormShapesFactory >> textColor [
	^ Color black
]
