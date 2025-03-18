"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
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
