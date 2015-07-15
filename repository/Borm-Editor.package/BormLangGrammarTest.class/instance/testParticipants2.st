tests
testParticipants2
	self
		parse:
			'System "Sys" {
	activity "x"
}
Organization "Org" {
	activity "x"
}'
		rule: #participants