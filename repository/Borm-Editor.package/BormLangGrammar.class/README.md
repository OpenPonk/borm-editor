I define and parse grammar of BORM Lang.

!! Example

Also see BormDiagramExamples for some examples.
[[[
'Person "Customer" {
	initial state "wants pizza"
		go to "order" if "hungry"
	
	activity "order"
		send "pizza choice" to "Operator::accepts order" and receive "confirmation"
		go to "wait"
	
	state "wait for pizza" as "wait"
		go to "pay"
	
	activity "accepts pizza and pays" as "pay"
		go to "final"
	
	final state "purchase completed" as "final"
}
System "Operator" {
	activity "accepts order"
}
' asBorm open
]]]