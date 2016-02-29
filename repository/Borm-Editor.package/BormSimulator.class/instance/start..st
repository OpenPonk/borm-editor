steps
start: aName
	self start: aName at: ((self model @ aName) nodes detect: #isInitial)