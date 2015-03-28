examples
openSingleParticipant
	<example>
	^ self
		openProject: 'Example BORM'
		diagram: 'Single Participant'
		dsl:
			'pUU(User){
s1(initial)
s1 -> a1
a1 -> sMid
sMid -> a2
s2(final)
a2 -> s2
}'