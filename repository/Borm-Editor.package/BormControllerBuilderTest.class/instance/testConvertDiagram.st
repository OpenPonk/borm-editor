tests
testConvertDiagram
	| diagram user ctrl builder tr a s |
	diagram := BormDiagram new name: 'BORM diagram'.
	user := BormParticipant new name: 'User'.
	diagram add: user.
	user
		add: (a := BormActivity new);
		add: (s := BormState new).
	tr := BormTransition from: a to: s.
	a addTransition: tr.
	s addTransition: tr.
	builder := BormControllerBuilder new.
	ctrl := builder createControllersFor: diagram.

	self assert: ctrl model equals: diagram