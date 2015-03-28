private - processing
processActivity: anArray
	| params activity |
	params := anArray second.
	activity := BormActivity new.
	activity name: (self nameFrom: anArray).
	dictionary at: anArray first put: activity.
	^ activity