ui hooks
buildEntityForm: aForm
	(aForm addEntity: 'Entity')
		displaySymbol: #name;
		entity: self model entity;
		whenEntityChanged: [ :e | 
			(e isKindOf: BormEntity)
				ifTrue: [ self model entity: e ] ];
		selectDialog: [ BormEntityListPresenter new
				addEntryLabel: 'New Entity';
				itemsBlock: [ self diagramController model project allBormEntities ] ]