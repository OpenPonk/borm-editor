"
Verifies the population, state, and execution of Commander 1 model commands within the BORM editor toolbar menu.
"
Class {
	#name : 'OPBormModelMenuTest',
	#superclass : 'TestCase',
	#instVars : [
		'toolbarPresenter',
		'mockWorkbench'
	],
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'running' }
OPBormModelMenuTest >> setUp [
	| mockProjectController |
	super setUp.
	mockWorkbench := Mock new.
	mockProjectController := Mock new.
	mockProjectController stub undoManager willReturn: OPUndoManager new.
	mockWorkbench stub projectController willReturn: mockProjectController.
	mockWorkbench stub workbench willReturn: mockWorkbench.
	toolbarPresenter := OPWorkbenchToolbar newApplication: SpApplication defaultApplication.
	toolbarPresenter owner: mockWorkbench
]

{ #category : 'running' }
OPBormModelMenuTest >> tearDown [
	toolbarPresenter := nil.
	mockWorkbench := nil.
	super tearDown
]

{ #category : 'tests' }
OPBormModelMenuTest >> testModelMenuContainsBormCommanderActivationsWhenBormEditorFocused [
	"Verifies that the Model menu contains BORM Commander 1 commands when a BORM editor is focused."
	| bormPlugin testEditor modelMenuItem subMenuLabels |
	bormPlugin := OPPluginRegistry default plugins
		detect: [ :eachPluginCandidate | eachPluginCandidate isKindOf: OPBormPlugin ].
	testEditor := (OPEditor on: bormPlugin)
		workbench: mockWorkbench;
		yourself.

	toolbarPresenter focusedEditor: testEditor.
	modelMenuItem := toolbarPresenter menu menuGroups first menuItems
		detect: [ :eachMenuItem | eachMenuItem name = 'Model' ].
	subMenuLabels := modelMenuItem subMenu menuGroups
		flatCollect: [ :eachGroup | eachGroup menuItems collect: [ :eachItem | eachItem name ] ].

	self assertCollection: subMenuLabels includesAll: #( 'DSL Editor' 'Simulation' )
]
