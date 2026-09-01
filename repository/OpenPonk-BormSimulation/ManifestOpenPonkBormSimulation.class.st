"
Manifest for the OpenPonk BORM Simulation package. Contains metadata and settings for the BORM simulation plugin and its critic rules.
"
Class {
	#name : 'ManifestOpenPonkBormSimulation',
	#superclass : 'PackageManifest',
	#category : 'OpenPonk-BormSimulation-Manifest',
	#package : 'OpenPonk-BormSimulation',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestOpenPonkBormSimulation class >> ruleClassNotReferencedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#OPBormSimulationGUI)) #'2025-03-18T17:15:24.367+01:00') )
]

{ #category : 'code-critics' }
ManifestOpenPonkBormSimulation class >> rulePrecedenceRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#OPBormSimulationGUI #adjustWindowSize #false)) #'2025-03-18T17:04:47.64+01:00') )
]

{ #category : 'code-critics' }
ManifestOpenPonkBormSimulation class >> ruleReShouldSendSuperInitializeAsFirstMessageV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#OPBormSimulationGUI #initialize #false)) #'2026-08-30T22:36:38.57+02:00') )
]
