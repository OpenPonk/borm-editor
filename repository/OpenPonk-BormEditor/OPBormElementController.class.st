Class {
	#name : 'OPBormElementController',
	#superclass : 'OPElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPBormElementController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	self buildEntityForm: aForm
]

{ #category : 'ui hooks' }
OPBormElementController >> buildEntityForm: aForm [

	self flag: 'Displays entry completion in wrong place'.

	(aForm addEntity: 'Entity')
		displaySymbol: #name;
		entity: self model entity;
		whenEntityChanged: [ :e |
			(e isKindOf: BormEntity) ifTrue: [
					self model entity: e.
					self diagramElement modelChanged ] ];
		"
		possibleEntities: [ 
			self diagramController model project allBormEntities sorted: [ :a :b | 
					a name < b name ] ]'"
		selectDialog: [
			BormEntityListPresenter new
				addEntryLabel: 'New Entity';
				itemsBlock: [
					self diagramController model project allBormEntities sorted: [
							:a
							:b | a name < b name ] ] ]
]

{ #category : 'testing' }
OPBormElementController >> isHideable [
	^ true
]
