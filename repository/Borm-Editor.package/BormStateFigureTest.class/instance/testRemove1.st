as yet unclassified
testRemove1
	figure
		model:
			(BormState new
				beInitial;
				beFinal).
	view add: figure.
	figure remove.
	self assert: view elements asArray equals: #()