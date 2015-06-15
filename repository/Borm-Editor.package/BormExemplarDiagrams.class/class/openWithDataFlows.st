examples
openWithDataFlows
	<example>
	self error: 'Data Flows are not yet fully implemented'.
	^ ('pUU(User){
s1(initial)
s1 -> a1
a1 -> sMid
sMid -> a2
s2(final)
a2 -> s2
a1 ->> pSS.a1 [(''input'')]
}
pSS(System, System){
s1(initial)
s1 -> a1
a1 -> sMid
sMid -> a2
s2(final)
a2 -> s2
a2 ->> pUU.a2 [(''input''), (''output'')]
}' asBorm: 'Data Flows Example') openAs: 'Example BORM with Data Flows'