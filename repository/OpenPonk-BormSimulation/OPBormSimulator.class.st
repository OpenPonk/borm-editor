Class {
	#name : 'OPBormSimulator',
	#superclass : 'OPDiagramSimulator',
	#instVars : [
		'presetConstraintsValue'
	],
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

{ #category : 'initialization' }
OPBormSimulator >> initialize [

	presetConstraintsValue := false.
	super initialize
]

{ #category : 'private - creation' }
OPBormSimulator >> loadItems [

	super loadItems.
	self simulableElements do: [ :each | each addInitialTokens ]
]

{ #category : 'accessing' }
OPBormSimulator >> presetConstraints [
	^ presetConstraintsValue
]

{ #category : 'accessing' }
OPBormSimulator >> presetConstraints: bool [

	presetConstraintsValue := bool
]

{ #category : 'stepping' }
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
