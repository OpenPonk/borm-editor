converting
transition: aTransition
	^ 'go to ' , (self name: aTransition target name) , (self constraint: aTransition constraint)