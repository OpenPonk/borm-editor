steps
send: aFlow from: sourceActivity to: targetActivity
	| from to el fromCtrl toCtrl |
	from := self model @ sourceActivity.
	to := self model @ targetActivity.
	el := self documentShape element.
	fromCtrl := self controllerForModel: from.
	toCtrl := self controllerForModel: to.
	self view add: el.
	self view signalUpdate.
	el translateTo: fromCtrl figure position.
	self view signalUpdate.
	self view addAnimation: (RTLinearMove to: toCtrl figure position during: 1 on: el).
	self view addAnimation: (RTNopAnimation new waitFor: 1 after: [ el remove ])