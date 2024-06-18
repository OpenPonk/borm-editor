Class {
	#name : 'OPBormAssociationEnhancementControllerTest',
	#superclass : 'OPBormControllerTest',
	#instVars : [
		'relationshipsSourceController',
		'relationshipsTargetController'
	],
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'testing' }
OPBormAssociationEnhancementControllerTest class >> isAbstract [

	^ self = OPBormAssociationEnhancementControllerTest
]

{ #category : 'initialization' }
OPBormAssociationEnhancementControllerTest >> setUpTarget [

	relationshipsSourceController := self targetsSourceControllerClass
		                                 new.
	relationshipsSourceController diagramController: diagramController.
	relationshipsSourceController createModelIn: diagramController model.
	relationshipsTargetController := OPBormActivityController new.
	relationshipsTargetController diagramController: diagramController.
	relationshipsTargetController createModelIn: diagramController model.
	relationshipController := self targetControllerClass new.
	relationshipController diagramController: diagramController.
	relationshipController
		source: relationshipsTargetController;
		target: relationshipsSourceController.
	relationshipController createModelIn:
		relationshipsSourceController model
]

{ #category : 'running' }
OPBormAssociationEnhancementControllerTest >> targetsSourceControllerClass [

	^ self subclassResponsibility
]

{ #category : 'tests' }
OPBormAssociationEnhancementControllerTest >> testCreateDiagramElement [

	relationshipController model add: model.
	diagramController addController: relationshipController.

	super testCreateDiagramElement
]
