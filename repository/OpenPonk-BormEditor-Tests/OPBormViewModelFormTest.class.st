"
Tests dynamic property form generation, field bindings, and validation for BORM view models.
"
Class {
	#name : 'OPBormViewModelFormTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'orModel',
		'registry'
	],
	#category : 'OpenPonk-BormEditor-Tests-ViewModels',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'running' }
OPBormViewModelFormTest >> setUp [
	super setUp.
	project := OPProject new.
	orModel := BormORModel new name: 'TestORModel'; yourself.
	project addModel: orModel.
	registry := OPViewModelRegistry forProject: project
]

{ #category : 'running' }
OPBormViewModelFormTest >> tearDown [
	registry := nil.
	orModel := nil.
	project := nil.
	super tearDown
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testDataFlowViewModelBindsType [

	| dataFlow viewModel form |
	dataFlow := BormDataFlow new
		            name: 'DF1';
		            type: #input;
		            yourself.
	orModel add: dataFlow.
	viewModel := registry viewModelFor: dataFlow.
	form := OPPropertiesForm new.
	form viewModel: viewModel.
	viewModel buildEditorForm: form.
	self assertCollection: (form bindings collect: #selector) includesAll: #( #type )
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testFormDroplistDisplayAndIconBlocks [

	| dataFlow dataFlowForm dataFlowDroplist participant participantForm participantDroplist state stateForm submodelDroplist inputTransitionDroplist inputCommunicationDroplist outputDroplist condition |
	dataFlow := BormDataFlow new
		            name: 'DF1';
		            type: #input;
		            yourself.
	orModel add: dataFlow.
	dataFlowForm := OPPropertiesForm new
		                viewModel: (registry viewModelFor: dataFlow);
		                yourself.
	(registry viewModelFor: dataFlow) buildEditorForm: dataFlowForm.
	dataFlowDroplist := (dataFlowForm bindings detect: [ :each | each selector = #type ]) presenter.
	self assert: (dataFlowDroplist display value: #input) equals: 'input'.

	participant := BormParticipant new
		               name: 'P1';
		               type: #Person;
		               yourself.
	orModel add: participant.
	participantForm := OPPropertiesForm new
		                   viewModel: (registry viewModelFor: participant);
		                   yourself.
	(registry viewModelFor: participant) buildEditorForm: participantForm.
	participantDroplist := (participantForm bindings detect: [ :each | each selector = #type ]) presenter.
	self assert: (participantDroplist display value: #Person) equals: 'Person'.
	self
		assert: ((participantDroplist displayIcon value: #Person) isKindOf: Form)
		description: 'Participant type droplist displayIcon must return a Form'.

	state := BormState named: 'S1'.
	orModel add: state.
	stateForm := OPPropertiesForm new
		             viewModel: (registry viewModelFor: state);
		             yourself.
	(registry viewModelFor: state) buildEditorForm: stateForm.
	submodelDroplist := (stateForm bindings detect: [ :each | each selector = #submodel ]) presenter.
	self assert: (submodelDroplist display value: nil) equals: ''.
	self assert: (submodelDroplist display value: orModel) equals: orModel name.

	condition := BormNodeSimulationCondition allSubclasses first new.
	inputTransitionDroplist := (stateForm bindings detect: [ :each | each selector = #inputTransitionSimulationCondition ]) presenter.
	inputCommunicationDroplist := (stateForm bindings detect: [ :each | each selector = #inputCommunicationSimulationCondition ])
		                              presenter.
	outputDroplist := (stateForm bindings detect: [ :each | each selector = #outputSimulationCondition ]) presenter.
	self assert: (inputTransitionDroplist display value: condition) equals: condition nameAsInput.
	self assert: (inputCommunicationDroplist display value: condition) equals: condition nameAsInput.
	self assert: (outputDroplist display value: condition) equals: condition nameAsOutput
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testORViewModelEssentialChildrenModelsIncludesParticipantsAndCommunications [

	| senderParticipant receiverParticipant senderActivity receiverActivity communication viewModel |
	senderParticipant := BormParticipant named: 'Customer'.
	receiverParticipant := BormParticipant named: 'Shop'.
	senderActivity := BormActivity named: 'Order'.
	receiverActivity := BormActivity named: 'Receive'.
	communication := BormCommunication named: 'OrderComm'.
	senderActivity send: communication.
	receiverActivity receive: communication.
	senderParticipant add: senderActivity.
	receiverParticipant add: receiverActivity.
	orModel
		add: senderParticipant;
		add: receiverParticipant.

	viewModel := registry viewModelFor: orModel.

	self assertCollection: viewModel essentialChildrenModels hasSameElements: {
			senderParticipant.
			receiverParticipant.
			communication }
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testParticipantEssentialChildrenModelsIncludesNodesAndTransitions [

	| participant state activity transition viewModel |
	participant := BormParticipant named: 'Customer'.
	state := BormState named: 'Start'.
	activity := BormActivity named: 'Order'.
	transition := BormTransition from: state to: activity.
	state addTransition: transition.
	activity addTransition: transition.
	participant
		add: state;
		add: activity.
	orModel add: participant.

	viewModel := registry viewModelFor: participant.

	self assertCollection: viewModel essentialChildrenModels hasSameElements: {
			state.
			activity.
			transition }
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testParticipantViewModelBindsType [

	| participant viewModel form |
	participant := BormParticipant new
		               name: 'P1';
		               type: #Person;
		               yourself.
	orModel add: participant.
	viewModel := registry viewModelFor: participant.
	form := OPPropertiesForm new.
	form viewModel: viewModel.
	viewModel buildEditorForm: form.
	self assertCollection: (form bindings collect: #selector) includesAll: #( #type )
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testPluginMetadataAndEmptyModel [

	| emptyModel |
	self assert: OPBormPlugin repositoryName equals: #'borm-editor'.
	emptyModel := OPBormExamples emptyModel.
	self assert: emptyModel class identicalTo: BormORModel.
	self assert: emptyModel name equals: 'ORD'.
	self assertEmpty: emptyModel participants
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testProcessNodeViewModelBindsAllProperties [

	| state viewModel form |
	state := BormState new
		         name: 'State1';
		         yourself.
	orModel add: state.
	viewModel := registry viewModelFor: state.
	form := OPPropertiesForm new.
	form viewModel: viewModel.
	viewModel buildEditorForm: form.
	self
		assertCollection: (form bindings collect: #selector)
		includesAll: #( #name #submodel #inputTransitionSimulationCondition #inputCommunicationSimulationCondition
			   #outputSimulationCondition )
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testProcessNodeViewModelBormModelsEdgeCases [

	| secondOrModel state viewModel emptyOrViewModel emptyViewModel detachedOrModel detachedState detachedRegistry detachedViewModel |
	secondOrModel := BormORModel named: 'SecondOR'.
	project addModel: secondOrModel.
	state := BormState named: 'S1'.
	orModel add: state.
	viewModel := registry viewModelFor: state.
	self assertCollection: viewModel bormModels hasSameElements: {
			orModel.
			secondOrModel }.

	emptyOrViewModel := OPBormORViewModel new.
	emptyOrViewModel
		instVarNamed: #registry put: registry;
		instVarNamed: #parentViewModel put: registry projectViewModel.
	emptyViewModel := OPBormStateViewModel new.
	emptyViewModel
		instVarNamed: #registry put: registry;
		instVarNamed: #parentViewModel put: emptyOrViewModel.
	self assertEmpty: emptyViewModel bormModels.

	detachedOrModel := BormORModel named: 'Detached'.
	detachedState := BormState named: 'DetachedState'.
	detachedOrModel add: detachedState.
	detachedRegistry := OPViewModelRegistry forProject: OPProject new.
	detachedViewModel := detachedRegistry viewModelFor: detachedState.
	self assertEmpty: detachedViewModel bormModels
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testStateViewModelBindsInitialAndFinal [

	| state viewModel form |
	state := BormState new
		         name: 'S1';
		         isInitial: true;
		         isFinal: false;
		         yourself.
	orModel add: state.
	viewModel := registry viewModelFor: state.
	form := OPPropertiesForm new.
	form viewModel: viewModel.
	viewModel buildEditorForm: form.
	self assertCollection: (form bindings collect: #selector) includesAll: #( #isInitial #isFinal )
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testViewModelIcons [

	| participant state activity transition communication constraint dataFlow |
	participant := BormParticipant named: 'P1'.
	state := BormState named: 'S1'.
	activity := BormActivity named: 'A1'.
	transition := BormTransition from: state to: activity.
	communication := BormCommunication named: 'C1'.
	constraint := BormConstraint named: 'Guard'.
	dataFlow := BormDataFlow named: 'DF1'.
	participant
		add: state;
		add: activity.
	orModel add: participant.

	{
		state.
		activity.
		transition.
		communication.
		constraint.
		dataFlow } do: [ :eachModel |
			| icon |
			icon := (registry viewModelFor: eachModel) icon.
			self assert: (icon isKindOf: Form) description: 'ViewModel icon must return a Form instance' ]
]
