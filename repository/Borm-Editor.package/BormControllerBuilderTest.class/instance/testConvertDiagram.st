tests
testConvertDiagram
	| diagram user ctrl builder tr a s |
	self skip.
	diagram := BormORModel new name: 'BORM diagram'.
	user := BormParticipant new name: 'User'.
	diagram add: user.
	user
		add: (a := BormActivity new);
		add: (s := BormState new).
	tr := BormTransition from: a to: s.
	a addTransition: tr.
	s addTransition: tr.
	builder := BormControllerBuilder new.
	builder
		view: RTView new;
		diagram: diagram.
	ctrl := builder build.

	self assert: ctrl model equals: diagram