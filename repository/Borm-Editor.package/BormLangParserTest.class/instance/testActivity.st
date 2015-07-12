tests
testActivity
	self parse: self resource emptyActivity rule: #activity.
	self assert: result equals: self resource activityHeaderParsed