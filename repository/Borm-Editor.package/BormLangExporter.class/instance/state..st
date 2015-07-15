converting
state: aState
	^ (self stateType: aState) , 'state' , ' ' , (self name: aState name)