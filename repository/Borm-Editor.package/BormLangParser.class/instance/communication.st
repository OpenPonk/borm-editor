accessing
communication
	^ super communication
		==> [ :arr | 
			| comm |
			comm := BormCommunication new.
			comm receiver: arr first.
			arr second ifNotNil: [ comm addDataFlowNamed: arr second ].
			arr third ifNotNil: [ (comm addDataFlowNamed: arr third) beOutput ].
			comm ]