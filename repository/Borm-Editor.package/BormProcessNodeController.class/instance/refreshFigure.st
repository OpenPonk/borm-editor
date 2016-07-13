hooks
refreshFigure
	(figure attributeAt: #RTLabelledLabel) text: self model name.
	(figure attributeAt: #RTLabelledLabel) pushFront.
	self model isSubmodelNode & plusBox view isNil
		ifTrue: [ figure view add: plusBox ].
	self model isSubmodelNode not & plusBox view isNotNil
		ifTrue: [ plusBox remove ].
	figure view signalUpdate