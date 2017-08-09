ui hooks
buildEditorForm: aForm
	(aForm addText: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | self model name: newValue asString ].
	(aForm addDroplist: 'Submodel')
		items: {nil} , self bormModels;
		displayBlock: [ :m | m ifNil: '' ifNotNil: #name ];
		setSelectedItem: self model submodel;
		whenSelectedItemChanged: [ :newValue | self model submodel: newValue ]