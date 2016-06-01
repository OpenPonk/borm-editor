as yet unclassified
registerModelEvents: aModel
	super registerModelEvents: aModel.
	aModel announcer
		when: DCModelContentReplaced
		do: [ self rebuild.
			self applyDefaultLayout.
			self view canvas focusOnCenterScaled ]