as yet unclassified
removeModelElement: aModelElement
	self model remove: aModelElement.
	self parent removeControllerOf: aModelElement