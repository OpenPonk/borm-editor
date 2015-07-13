accessing
node
	^ (activity / state , communications , transitions)
		==> [ :arr | 
			{(#node -> arr first).
			(#comm -> arr second).
			(#trans -> arr third)} asDictionary ]