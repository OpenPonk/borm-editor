"
An abstract base class for Commander 1 model commands executed within a BORM process editor.
"
Class {
	#name : 'OPBormCommand',
	#superclass : 'OPModelCommand',
	#category : 'OpenPonk-BormEditor-Commands',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPBormCommand class >> canBeExecutedInEditor: anEditor [
	"Answers true if the active editor plugin is BORM."
	^ anEditor plugin isKindOf: OPBormPlugin
]

{ #category : 'testing' }
OPBormCommand class >> isAbstract [
	"Answers true if this class is the abstract root of BORM model commands."
	^ self = OPBormCommand
]
