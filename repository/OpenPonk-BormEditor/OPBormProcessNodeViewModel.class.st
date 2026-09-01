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

	(aForm addText: 'Name')
		text: self model name;
		whenTextChangedDo: [ :newValue |
			self model name: newValue asString.
			self modelChanged ].
	
	(aForm addDroplist: 'Submodel')
		items: { nil } , self bormModels;
		display: [ :m | m ifNil: '' ifNotNil: #name ];
		selectItem: self model submodel;
		whenSelectedItemChangedDo: [ :newValue |
			self model submodel: newValue.
			self modelChanged ].
	(aForm addDroplist: 'Input Transition Condition')
		items: (BormNodeSimulationCondition allSubclasses collect: #new);
		display: [ :type | type nameAsInput ];
		selectItem: self model inputTransitionSimulationCondition;
		whenSelectedItemChangedDo: [ :newValue |
			self model inputTransitionSimulationCondition: newValue ].
	(aForm addDroplist: 'Input Communication Condition')
		items: (BormNodeSimulationCondition allSubclasses collect: #new);
		display: [ :type | type nameAsInput ];
		selectItem: self model inputCommunicationSimulationCondition;
		whenSelectedItemChangedDo: [ :newValue |
			self model inputCommunicationSimulationCondition: newValue ].
	(aForm addDroplist: 'Output Condition')
		items: (BormNodeSimulationCondition allSubclasses collect: #new);
		display: [ :type | type nameAsOutput ];
		selectItem: self model outputSimulationCondition;
		whenSelectedItemChangedDo: [ :newValue |
			self model outputSimulationCondition: newValue ]
]

{ #category : 'accessing' }
OPBormProcessNodeViewModel >> childrenModels [

	^ self model transitions
]
