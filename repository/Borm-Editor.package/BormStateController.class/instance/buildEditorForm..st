hooks
buildEditorForm: aForm
	super buildEditorForm: aForm.

	(aForm addCheckbox: 'Initial')
		state: self model isInitial;
		whenChangedDo: [ :newValue | self model isInitial: newValue ].

	(aForm addCheckbox: 'Final')
		state: self model isFinal;
		whenChangedDo: [ :newValue | self model isFinal: newValue ]