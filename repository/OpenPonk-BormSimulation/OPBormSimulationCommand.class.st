"
A model command that starts the execution simulation for the active BORM business process model.
"
Class {
	#name : 'OPBormSimulationCommand',
	#superclass : 'OPBormCommand',
	#category : 'OpenPonk-BormSimulation-Simulation',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Simulation'
}

{ #category : 'activation' }
OPBormSimulationCommand class >> modelMenuActivation [
	<classAnnotation>
	^ OPModelMenuActivation
		byItemOf: OPModelBasicMenuGroup
		order: 10
		for: OPEditor
]

{ #category : 'accessing' }
OPBormSimulationCommand >> defaultMenuIconName [
	"Answers the icon name for the BORM simulation command."
	^ #glamorousSpawn
]

{ #category : 'accessing' }
OPBormSimulationCommand >> defaultMenuItemName [
	"Answers the display name of the BORM simulation command."
	^ 'Simulation'
]

{ #category : 'execution' }
OPBormSimulationCommand >> execute [
	"Opens the BORM simulation GUI for the active diagram controller."
	OPBormSimulationGUI diagramController: self diagramController
]
