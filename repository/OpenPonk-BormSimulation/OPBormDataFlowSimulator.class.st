"
Simulator component for BORM data flows.
Manages data token transfers during diagram execution.
"
Class {
	#name : 'OPBormDataFlowSimulator',
	#superclass : 'OPElementSimulator',
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'testing' }
OPBormDataFlowSimulator >> isSimulable [
	^ false
]
