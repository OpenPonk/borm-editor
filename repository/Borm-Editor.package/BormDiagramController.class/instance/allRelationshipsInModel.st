rebuilding
allRelationshipsInModel
	^ self model elements
		flatCollect: [ :eachParticipant | 
			eachParticipant nodes
				flatCollect: [ :eachNode | 
					eachNode outgoing
						,
							((eachNode respondsTo: #sent)
								ifTrue: [ eachNode sent ]
								ifFalse: [ #() ]) ] ]