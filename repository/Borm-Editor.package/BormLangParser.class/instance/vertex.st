accessing
vertex
	^ (activity / state , newLine optional, dataFlows , newLine optional, transitions)
		==> [ :arr | 
			{(arr first).
			(arr last).
			(arr third)} ]