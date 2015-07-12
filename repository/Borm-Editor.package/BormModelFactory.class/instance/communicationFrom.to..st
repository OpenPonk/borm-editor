accessing
communicationFrom: sourceActivity to: targetActivity
	| comm |
	comm := BormCommunication from: sourceActivity to: targetActivity.
	sourceActivity send: comm.
	targetActivity receive: comm.
	^ comm