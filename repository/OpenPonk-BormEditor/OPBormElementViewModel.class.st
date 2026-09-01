"
I am the abstract base ViewModel for BORM elements, handling the linking of model properties and semantic entities to the UI editor forms.
"
Class {
	#name : 'OPBormElementViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'testing' }
OPBormElementViewModel class >> isAbstract [

	^ self = OPBormElementViewModel
]

{ #category : 'forms' }
OPBormElementViewModel >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	self buildEntityForm: aForm
]

{ #category : 'forms' }
OPBormElementViewModel >> buildEntityForm: aForm [
	self flag: 'Displays entry completion in wrong place'.
	(aForm addEntity: 'Entity')
		displaySymbol: #name;
		entity: self model entity;
		whenEntityChanged: [ :e |
			(e isKindOf: BormEntity) ifTrue: [
					self model entity: e.
					self modelChanged ] ];
		selectDialog: [
			BormEntityListPresenter new
				addEntryLabel: 'New Entity';
				itemsBlock: [
					| project |
					project := (self modelRootViewModel ifNotNil: #model) ifNotNil: #project.
					project
						ifNil: [ #() ]
						ifNotNil: [ project allBormEntities sorted: [ :a :b | a name < b name ] ] ] ]
]
