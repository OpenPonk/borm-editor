tests
testParticipant3
	self
		parse:
			'Organization "Org" {
	state "x x" as "x"
		go to "y"
	activity "y y" as "y"
}'
		rule: #participant