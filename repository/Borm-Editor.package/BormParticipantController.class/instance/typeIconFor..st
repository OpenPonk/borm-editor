hooks
typeIconFor: aType
	aType = BormParticipantType Person
		ifTrue: [ ^ BormEditorIcons current personIcon ].
	aType = BormParticipantType System
		ifTrue: [ ^ BormEditorIcons current systemIcon ].
	aType = BormParticipantType Organization
		ifTrue: [ ^ BormEditorIcons current organizationIcon ]