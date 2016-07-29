*Borm-Editor
allBormEntities
	"Use only participant's entities for now.	^ (self models select: [ :each | each isKindOf: BormORModel ]) flatCollect: #allEntities"

	^ ((self models select: [ :each | each isKindOf: BormORModel ]) flatCollect: #participants)
		collect: #entity as: Set