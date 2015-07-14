tests
testDiagram
	self
		parse:
			'System "Src" {
	activity "a"
		talk to "Dst::a"
}
Organization "Dst" {
	activity "a"
}'
		rule: #diagram