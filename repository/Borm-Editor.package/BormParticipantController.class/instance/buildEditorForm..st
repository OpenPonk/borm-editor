hooks
buildEditorForm: aForm
	super buildEditorForm: aForm.

	(aForm addDroplist: 'Type')
		items: #(#Person #System #Organization);
		iconHolder: [ :type | self typeIconFor: type ];
		displayBlock: [ :type | type asString ];
		setSelectedItem: self model type;
		whenSelectedItemChanged: [ :newValue | self model type: newValue ]