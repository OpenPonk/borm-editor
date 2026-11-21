"
I am an abstract base test class verifying the common interaction, connectivity, and canvas targeting rules shared by BORM process node controllers (States and Activities).
"
Class {
	#name : 'OPBormProcessNodeControllerTest',
	#superclass : 'OPBormElementControllerTest',
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'testing' }
OPBormProcessNodeControllerTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self = OPBormProcessNodeControllerTest
]

{ #category : 'tests' }
OPBormProcessNodeControllerTest >> testPlusIconClickOpensSubmodelEditor [

	| submodel openedModel mockWorkbench mockEditor participantController plusIcon |
	submodel := BormORModel named: 'Submodel'.
	openedModel := nil.
	mockWorkbench := Mock new.
	(mockWorkbench stub openEditorOn: submodel) will: [ openedModel := submodel ].
	mockEditor := Mock new.
	mockEditor stub workbench willReturn: mockWorkbench.
	diagramController editor: mockEditor.

	participantController := OPBormParticipantController new.
	participantController diagramController: diagramController.
	participantController createModelIn: diagramController model.
	diagramController addController: participantController.
	participantController
		createDiagramElement;
		renderDiagramElement.

	controller createModelIn: participantController model.
	controller model submodel: submodel.
	diagramController addController: controller.
	controller
		createDiagramElement;
		renderDiagramElement.

	plusIcon := controller diagramElement instVarNamed: #plusIcon.
	plusIcon announce: RSMouseLeftClick new.

	self assert: openedModel identicalTo: submodel
]
