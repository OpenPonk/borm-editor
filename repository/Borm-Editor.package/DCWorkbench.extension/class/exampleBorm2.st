*Borm-Editor
exampleBorm2
	<example: 'DynaCASE example BORM2'>
	| diagram project spec |
	project := DCProject new projectName: 'Example BORM'.
	spec := 'pUU(User){
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
}'.
	diagram := BormDslModelBuilder new parse: spec.
	project addDiagram: diagram.
	^ self openProject: project