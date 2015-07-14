tests
testParticipants3
	self
		parse:
			'System "Sys" {
	activity "a1"
		go to "s1"
	state "s1"
}
Organization "Org" {
	activity "a2"
		go to "s2"
	state "s2"
}'
		rule: #participants