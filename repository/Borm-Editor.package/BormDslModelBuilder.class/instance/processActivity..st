private - processing
processActivity: anArray
	| params activity |
	params := anArray second.
	activity := nodes at: anArray first ifPresent: [ :n | n ] ifAbsent: [ BormActivity new ].
	activity name: (self nameFrom: anArray).
	nodes at: anArray first put: activity.
	^ activity