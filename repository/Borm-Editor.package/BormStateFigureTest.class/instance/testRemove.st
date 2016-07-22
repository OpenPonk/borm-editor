as yet unclassified
testRemove
	figure model: BormState new.
	view add: figure.
	figure remove.
	self assert: view elements asArray equals: #()