tests
testDiagram2
	self
		parse:
			'System "Src" {
	activity "a"
		talk to "Dst::a"
}
Organization "Dst" {
	activity "a"
		send "x" to "Src::a" and receive "y"
}'
		rule: #diagram