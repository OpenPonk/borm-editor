converting
activityNode: anActivity
	^ (self activity: anActivity) , (self newLineIf: anActivity sent isNotEmpty), (self communications: anActivity sent)