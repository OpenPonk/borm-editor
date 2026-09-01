"
I am the ViewModel for BORM Communications. I bridge the semantic communication model with its visual edge shape and manage nested data flow children.
"
Class {
	#name : 'OPBormCommunicationViewModel',
	#superclass : 'OPDirectedAssociationViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPBormCommunicationViewModel class >> modelClass [ ^ BormCommunication
]

{ #category : 'construction' }
OPBormCommunicationViewModel >> attachModelFrom: sourceViewModel to: targetViewModel [

	self model source: sourceViewModel model.
	self model target: targetViewModel model.
	sourceViewModel model send: self model.
	targetViewModel model receive: self model
]

{ #category : 'private' }
OPBormCommunicationViewModel >> basicRemoveModel [

	self model target removeCommunication: self model.
	self model source removeCommunication: self model
]

{ #category : 'accessing' }
OPBormCommunicationViewModel >> essentialChildrenModels [

	^ self model constraints asArray , self model dataFlows asArray
]

{ #category : 'accessing' }
OPBormCommunicationViewModel >> icon [ ^ OPBormEditorIcons communication16Icon
]

{ #category : 'construction' }
OPBormCommunicationViewModel >> registerModelIn: aParentModel [
	"There is no owner except of source/target"

	
]
