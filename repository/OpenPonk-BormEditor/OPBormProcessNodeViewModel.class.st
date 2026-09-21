"
I am the abstract base ViewModel for BORM process nodes. I connect the semantic state or activity models to their corresponding visual shapes and property forms.
"
Class {
	#name : 'OPBormProcessNodeViewModel',
	#superclass : 'OPBormElementViewModel',
	#category : 'OpenPonk-BormEditor-ViewModels',
	#package : 'OpenPonk-BormEditor',
	#tag : 'ViewModels'
}

{ #category : 'testing' }
OPBormProcessNodeViewModel class >> isAbstract [

	^ self = OPBormProcessNodeViewModel
]

{ #category : 'forms' }
OPBormProcessNodeViewModel >> bormModels [
	| rootModel project |
	rootModel := self modelRootViewModel ifNotNil: #model.
	rootModel ifNil: [ ^ #() ].
	project := rootModel project.
	project ifNil: [ ^ #() ].
	^ project models select: [ :each | each isKindOf: rootModel class ]
]

{ #category : 'forms' }
OPBormProcessNodeViewModel >> buildEditorForm: aForm [

	aForm bindTextInput: 'Name' property: #name.
	(aForm
		bindDroplist: 'Submodel'
		property: #submodel
		items: { nil } , self bormModels)
			display: [ :eachSubmodel | eachSubmodel ifNil: [ '' ] ifNotNil: #name ].
	(aForm
		bindDroplist: 'Input Transition Condition'
		property: #inputTransitionSimulationCondition
		items: (BormNodeSimulationCondition allSubclasses collect: #new))
			display: [ :eachCondition | eachCondition nameAsInput ].
	(aForm
		bindDroplist: 'Input Communication Condition'
		property: #inputCommunicationSimulationCondition
		items: (BormNodeSimulationCondition allSubclasses collect: #new))
			display: [ :eachCondition | eachCondition nameAsInput ].
	(aForm
		bindDroplist: 'Output Condition'
		property: #outputSimulationCondition
		items: (BormNodeSimulationCondition allSubclasses collect: #new))
			display: [ :eachCondition | eachCondition nameAsOutput ]
]

{ #category : 'accessing' }
OPBormProcessNodeViewModel >> childrenModels [

	^ self model transitions
]
