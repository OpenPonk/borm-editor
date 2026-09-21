Class {
	#name : 'OPBormViewModelFormTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'orModel',
		'registry'
	],
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
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
	dataFlow := BormDataFlow new name: 'DF1'; type: #input; yourself.
	orModel add: dataFlow.
	viewModel := registry viewModelFor: dataFlow.
	form := OPPropertiesForm new.
	form viewModel: viewModel.
	viewModel buildEditorForm: form.
	self assert: (form bindings anySatisfy: [ :eachBinding | eachBinding selector = #type ])
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testParticipantViewModelBindsType [
	| participant viewModel form |
	participant := BormParticipant new name: 'P1'; type: #Person; yourself.
	orModel add: participant.
	viewModel := registry viewModelFor: participant.
	form := OPPropertiesForm new.
	form viewModel: viewModel.
	viewModel buildEditorForm: form.
	self assert: (form bindings anySatisfy: [ :eachBinding | eachBinding selector = #type ])
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testProcessNodeViewModelBindsAllProperties [
	| state viewModel form |
	state := BormState new name: 'State1'; yourself.
	orModel add: state.
	viewModel := registry viewModelFor: state.
	form := OPPropertiesForm new.
	form viewModel: viewModel.
	viewModel buildEditorForm: form.
	self assert: (form bindings anySatisfy: [ :eachBinding | eachBinding selector = #name ]).
	self assert: (form bindings anySatisfy: [ :eachBinding | eachBinding selector = #submodel ]).
	self assert: (form bindings anySatisfy: [ :eachBinding | eachBinding selector = #inputTransitionSimulationCondition ]).
	self assert: (form bindings anySatisfy: [ :eachBinding | eachBinding selector = #inputCommunicationSimulationCondition ]).
	self assert: (form bindings anySatisfy: [ :eachBinding | eachBinding selector = #outputSimulationCondition ])
]

{ #category : 'tests' }
OPBormViewModelFormTest >> testStateViewModelBindsInitialAndFinal [
	| state viewModel form |
	state := BormState new name: 'S1'; isInitial: true; isFinal: false; yourself.
	orModel add: state.
	viewModel := registry viewModelFor: state.
	form := OPPropertiesForm new.
	form viewModel: viewModel.
	viewModel buildEditorForm: form.
	self assert: (form bindings anySatisfy: [ :eachBinding | eachBinding selector = #isInitial ]).
	self assert: (form bindings anySatisfy: [ :eachBinding | eachBinding selector = #isFinal ])
]
