"
I am a utility factory that creates and styles basic Roassal shapes (such as colored boxes and borders) used in BORM diagram visualizations.
"
Class {
	#name : 'BormShapesFactory',
	#superclass : 'Object',
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
BormShapesFactory >> backgroundColor [
	^ Color white
]

{ #category : 'accessing' }
BormShapesFactory >> borderColor [
	^ Color black
]

{ #category : 'instance creation' }
BormShapesFactory >> newBox [

	^ RSBox new
		  color: self backgroundColor;
		  borderColor: self borderColor;
		  yourself
]

{ #category : 'instance creation' }
BormShapesFactory >> newRoundedBox [

	^ RSBox new
		  color: self backgroundColor;
		  borderColor: self borderColor;
		  cornerRadius: 20;
		  yourself
]

{ #category : 'accessing' }
BormShapesFactory >> textColor [
	^ Color black
]
