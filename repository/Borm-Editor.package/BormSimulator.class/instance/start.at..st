steps
start: aName at: aNode
	| participant el fromCtrl node |
	participant := self model @ aName.
	el := self personShape elementOn: participant.
	node := aNode.
	node isString
		ifTrue: [ node := participant @ aNode ].
	fromCtrl := self controllerForModel: node.
	self view add: el.
	self view signalUpdate.
	el translateTo: fromCtrl figure position.
	self view signalUpdate.
	states at: aName put: el