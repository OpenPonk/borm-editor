samples
sampleDataFlows
	<sample>
	| diagram user sys |
	diagram := BormORModel named: 'Two Participants'.
	user := BormParticipant named: 'User'.
	(sys := BormParticipant named: 'System') type: BormParticipantType System.
	
	diagram addAll: { user . sys }.

	user
		addAll: {
			(BormState named: 'init') beInitial.
			BormActivity named: 'a1'.
			BormState named: 'sMid'.
			BormActivity named: 'a2'.
			(BormState named: 's2') beFinal
	}.

	user @ 'init' -> (user @ 'a1').
	user @ 'a1' -> (user @ 'sMid').
	user @ 'sMid' -> (user @ 'a2').
	user @ 'a2' -> (user @ 's2').

	sys addAll: {
		(BormState named: 's1') beInitial.
		BormActivity named: 'a1'.
		BormState named: 'sMid'.
		BormActivity named: 'a2'.
		(BormState named: 's2') beFinal.
	}.
	
	BormFactory addFqnTransitions: { 
		's1' -> 'a1'.
		'a1' -> 'sMid'.
		'sMid' -> 'a2'.
		'a2' -> 's2'.
	} in: sys.
	
	
	(user @ 'a1' ==> (sys @ 'a1'))
		addDataFlowNamed: 'input'.
	
	(diagram @ 'System::a2' ==> (diagram @ 'User::a2'))
		addDataFlow: ((BormDataFlow named: 'output') beOutput).
	
	 ^ diagram