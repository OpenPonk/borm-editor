"
Simulator component for BORM states.
Acts as a resting or waiting phase in a participant's lifecycle, managing the accumulation and dispatch of tokens.
"
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
