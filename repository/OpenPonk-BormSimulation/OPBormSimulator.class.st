"
Simulator for BORM diagrams.
Coordinates overall execution flow, manages global stepping, and initializes preset constraint values across the diagram.
"
Class {
	#name : 'OPBormSimulator',
	#superclass : 'OPDiagramSimulator',
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'initialization' }
OPBormSimulator class >> initialClassMapping [
	^ super initialClassMapping
		at: BormParticipant put: OPBormParticipantSimulator;
		at: BormActivity put: OPBormActivitySimulator;
		at: BormState put: OPBormStateSimulator;
		at: BormDataFlow put: OPBormDataFlowSimulator;
		at: BormTransition put: OPBormTransitionSimulator;
		at: BormCommunication put: OPBormCommunicationSimulator;
		at: BormConstraint put: OPBormConstraintSimulator;
		yourself
]

{ #category : 'accessing' }
OPBormSimulator >> blockedByConstraintElements [

	^ self simulableElements select: [ :eachElement | eachElement isBlockedByConstraints ]
]

{ #category : 'private - creation' }
OPBormSimulator >> loadItems [

	super loadItems.
	self simulableElements do: [ :each | each addInitialTokens ]
]

{ #category : 'initialization' }
OPBormSimulator >> setDefaultStepping [
	"sets default stepping settings"

	super setDefaultStepping.
	self
		fromSteppableElements;
		orderAny;
		selectAll;
		resetActions;
		addAction: [ :item | item step ]
]
