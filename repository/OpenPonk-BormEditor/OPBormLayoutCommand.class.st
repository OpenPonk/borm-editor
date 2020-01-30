Class {
	#name : #OPBormLayoutCommand,
	#superclass : #OPLayoutDiagramCommand,
	#category : #'OpenPonk-BormEditor-Adapters'
}

{ #category : #accessing }
OPBormLayoutCommand >> defaultMenuItemName [
	^ 'Default'
]

{ #category : #execution }
OPBormLayoutCommand >> execute [
	layouter defaultLayout
]
