hooks
buildEditorForm: aForm
	super buildEditorForm: aForm.
	aForm
		addCheckbox: 'initial'
		label: 'initial'
		value: self model isInitial
		onChange: [ :newValue | self model isInitial: newValue ].
	aForm
		addCheckbox: 'final'
		label: 'final'
		value: self model isFinal
		onChange: [ :newValue | self model isFinal: newValue ]