hooks
createModel
	^ self model
		ifNil: [ 
			self modelClass new
				name: 'constraint';
				yourself ]