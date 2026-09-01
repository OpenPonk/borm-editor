"
I am a context menu command that triggers the OPBormLayouter to automatically arrange participants and their internal process nodes on the diagram canvas.
"
Class {
	#name : 'OPBormLayoutCommand',
	#superclass : 'OPLayoutDiagramCommand',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormLayoutCommand >> defaultMenuItemName [
	^ 'Default'
]

{ #category : 'execution' }
OPBormLayoutCommand >> execute [
	layouter defaultLayout
]
