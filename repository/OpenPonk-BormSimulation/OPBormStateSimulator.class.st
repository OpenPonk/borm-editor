Class {
	#name : 'OPBormStateSimulator',
	#superclass : 'OPBormElementSimulator',
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'initialization' }
OPBormStateSimulator >> setDefaultStepping [
	"sets default stepping settings"

	super setDefaultStepping.
	self
		resetActions;
		addAction: [ :item | item process ]
]
