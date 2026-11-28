"
Verifies BORM diagram simulator class-mapping registration for all supported BORM metamodel elements.
"
Class {
	#name : 'OPBormSimulatorTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-BormSimulation-Tests-Simulation',
	#package : 'OpenPonk-BormSimulation-Tests',
	#tag : 'Simulation'
}

{ #category : 'tests' }
OPBormSimulatorTest >> testInitialClassMappingContainsAllSupportedBormModels [

	| mapping |
	mapping := OPBormSimulator initialClassMapping.
	self assert: (mapping at: BormParticipant) identicalTo: OPBormParticipantSimulator.
	self assert: (mapping at: BormActivity) identicalTo: OPBormActivitySimulator.
	self assert: (mapping at: BormState) identicalTo: OPBormStateSimulator.
	self assert: (mapping at: BormDataFlow) identicalTo: OPBormDataFlowSimulator.
	self assert: (mapping at: BormTransition) identicalTo: OPBormTransitionSimulator.
	self assert: (mapping at: BormCommunication) identicalTo: OPBormCommunicationSimulator.
	self assert: (mapping at: BormConstraint) identicalTo: OPBormConstraintSimulator
]
