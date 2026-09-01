"
Simulator component for BORM participants.
Manages the execution context and token boundaries for elements contained within a specific participant.
"
Class {
	#name : 'OPBormParticipantSimulator',
	#superclass : 'OPElementSimulator',
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'testing' }
OPBormParticipantSimulator >> isSimulable [

	^ false
]
