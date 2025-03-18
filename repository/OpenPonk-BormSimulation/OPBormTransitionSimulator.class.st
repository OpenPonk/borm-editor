Class {
	#name : 'OPBormTransitionSimulator',
	#superclass : 'OPEdgeSimulator',
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'testing' }
OPBormTransitionSimulator >> isSimulable [

	^ false
]

{ #category : 'testing' }
OPBormTransitionSimulator >> isSteppable [
	^ false
]
