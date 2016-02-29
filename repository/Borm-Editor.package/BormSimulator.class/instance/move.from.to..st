steps
move: aName from: sourceName to: targetName
	| from to el fromCtrl toCtrl |
	from := self model @ aName @ sourceName.
	to := self model @ aName @ targetName.
	fromCtrl := self controllerForModel: from.
	toCtrl := self controllerForModel: to.
	el := states at: aName.
	self view addAnimation: (RTLinearMove to: toCtrl figure position during: 1 on: el).
"	self view addAnimation: (RTNopAnimation new waitFor: 1 after: [ el remove ])"