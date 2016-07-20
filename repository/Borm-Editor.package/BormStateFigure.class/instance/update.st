as yet unclassified
update
	self show: playIcon if: self model isInitial.
	self show: innerBox if: self model isFinal.
	super update