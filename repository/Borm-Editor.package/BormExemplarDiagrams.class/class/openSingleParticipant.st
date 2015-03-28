as yet unclassified
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
a1 ->> pSS.a1
}
pSS(System, System){
s1(initial)
s1 -> a1
a1 -> sMid
sMid -> a2
s2(final)
a2 -> s2
a2 ->> pUU.a2
}'