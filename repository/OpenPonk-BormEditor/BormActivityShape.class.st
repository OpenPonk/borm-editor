Class {
	#name : 'BormActivityShape',
	#superclass : 'BormNodeShape',
	#category : 'OpenPonk-BormEditor-DiagramElements',
	#package : 'OpenPonk-BormEditor',
	#tag : 'DiagramElements'
}

{ #category : 'as yet unclassified' }
BormActivityShape >> renderBasicShape [

	^ self shapesFactory newRoundedBox
		  width: self defaultSize x;
		  height: self defaultSize y;
		  color: (Color fromHexString: 'f2f2f2');
		  yourself
]
