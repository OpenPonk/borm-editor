"
I am the abstract base controller for all BORM diagram elements, providing common logic for UI bindings and entity form generation.
"
Class {
	#name : 'OPBormElementController',
	#superclass : 'OPElementController',
	#category : 'OpenPonk-BormEditor-Controllers',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Controllers'
}

{ #category : 'deprecation' }
OPBormElementController >> buildEntityForm: aForm [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver buildEntityForm: `@arg1' -> '`@receiver viewModel buildEntityForm: `@arg1'.
	^ self viewModel buildEntityForm: aForm
]
