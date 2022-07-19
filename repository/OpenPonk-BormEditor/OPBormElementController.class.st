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

	self flag: 'Displays entry completion in wrong place'.

	(aForm addEntity: 'Entity')
		displaySymbol: #name;
		entity: self model entity;
		whenEntityChanged: [ :e | 
			(e isKindOf: BormEntity) ifTrue: [ 
					self model entity: e.
					self refreshFigure ] ];
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

{ #category : #testing }
OPBormElementController >> isHideable [
	^ true
]

{ #category : #accessing }
OPBormElementController >> layout [
	^ OPElementLayout
		withPosition: self figure position
		extent: self figure extent
]
