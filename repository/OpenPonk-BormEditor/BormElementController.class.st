Class {
	#name : #BormElementController,
	#superclass : #OPElementController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #'ui hooks' }
BormElementController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	self buildEntityForm: aForm
]

{ #category : #'ui hooks' }
BormElementController >> buildEntityForm: aForm [
	(aForm addEntity: 'Entity')
		displaySymbol: #name;
		entity: self model entity;
		whenEntityChanged: [ :e | 
			(e isKindOf: BormEntity)
				ifTrue: [ self model entity: e ] ];
		selectDialog: [ BormEntityListPresenter new
				addEntryLabel: 'New Entity';
				itemsBlock: [ self diagramController model project allBormEntities ] ]
]
