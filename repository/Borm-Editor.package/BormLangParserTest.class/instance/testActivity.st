tests
testActivity
	self parse: self emptyActivity rule: #activity.
	self assert: result equals: self activityParsed