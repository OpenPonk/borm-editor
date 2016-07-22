as yet unclassified
testAdd
	figure model: BormState new.
	view add: figure.
	self assert: view elements asSet equals: {figure} asSet , figure ownedElements