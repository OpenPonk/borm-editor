Class {
	#name : #OPBormElementController,
	#superclass : #OPElementController,
	#category : #'OpenPonk-BormEditor-Controllers'
}

{ #category : #'ui hooks' }
OPBormElementController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	self buildEntityForm: aForm
]

{ #category : #'ui hooks' }
OPBormElementController >> buildEntityForm: aForm [
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

{ #category : #testing }
OPBormElementController >> isHideable [
	^ true
]
