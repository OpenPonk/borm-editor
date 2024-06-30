Class {
	#name : 'OPBormRelationshipControllerTest',
	#superclass : 'OPAbstractDirectionalRelationshipControllerTest',
	#instVars : [
		'sourceController'
	],
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'testing' }
OPBormRelationshipControllerTest class >> isAbstract [
	^ self = OPBormRelationshipControllerTest
]

{ #category : 'accessing' }
OPBormRelationshipControllerTest >> diagramControllerClass [

	^ OPBormDiagramController
]

{ #category : 'accessing' }
OPBormRelationshipControllerTest >> diagramModelClass [
	^ BormORModel
]
