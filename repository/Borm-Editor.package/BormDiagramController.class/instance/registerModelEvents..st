as yet unclassified
registerModelEvents: aModel
	super registerModelEvents: aModel.
	aModel announcer
		when: OPModelContentReplaced
		do: [ self rebuild.
			self applyDefaultLayout.
			self view canvas focusOnCenterScaled ]