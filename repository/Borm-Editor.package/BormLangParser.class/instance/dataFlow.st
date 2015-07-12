accessing
dataFlow
	^ sendDataFlow / receiveDataFlow
		==> [ :arr | 
			{(arr first).
			(arr third).
			(arr seventh)} ]