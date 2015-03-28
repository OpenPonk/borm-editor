hooks
typeIconFor: aType
	aType = BormParticipantType Person
		ifTrue: [ ^ BormEditorIcons personIcon ].
	aType = BormParticipantType System
		ifTrue: [ ^ BormEditorIcons systemIcon ].
	aType = BormParticipantType Organization
		ifTrue: [ ^ BormEditorIcons organizationIcon ]