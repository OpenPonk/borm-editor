"
I verify Undo and Redo cycles for BORM model elements.
"
Class {
	#name : 'OPBormUndoRedoTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'undoManager',
		'projectController'
	],
	#category : 'OpenPonk-BormEditor-Tests',
	#package : 'OpenPonk-BormEditor',
	#tag : 'Tests'
}

{ #category : 'running' }
OPBormUndoRedoTest >> setUp [
	super setUp.
	project := OPProject new.
	undoManager := OPUndoManager new.
	projectController := OPProjectController forProject: project.
	projectController instVarNamed: #undoManager put: undoManager
]

{ #category : 'tests' }
OPBormUndoRedoTest >> testCommunicationUndoRedoCycle [
	| activity1 activity2 communication removeCommand |
	activity1 := BormActivity new name: 'A1'.
	activity2 := BormActivity new name: 'A2'.
	communication := BormCommunication new name: 'Comm'.
	activity1 send: communication.
	activity2 receive: communication.

	project addModel: activity1.
	project addModel: activity2.

	self assert: (activity1 communications includes: communication).
	self assert: (activity2 communications includes: communication).

	removeCommand := OPRemoveModelElementCommand
		model: communication
		projectController: projectController.

	undoManager execute: removeCommand.
	self deny: (activity1 communications includes: communication).
	self deny: (activity2 communications includes: communication).

	undoManager undo.
	self assert: (activity1 communications includes: communication)
		description: 'Communication must be restored in sender activity upon undo'.
	self assert: (activity2 communications includes: communication)
		description: 'Communication must be restored in receiver activity upon undo'.

	undoManager redo.
	self deny: (activity1 communications includes: communication).
	self deny: (activity2 communications includes: communication)
]

{ #category : 'tests' }
OPBormUndoRedoTest >> testDataFlowLabelRemainsTopAlignedAfterSettingText [
	| canvas flowShape dataFlow label initialYPosition afterTextYPosition |
	canvas := RSCanvas new extent: 800 @ 600.
	dataFlow := BormDataFlow new name: ''.
	flowShape := BormDataFlowShape in: OPNoShape instance forModelElement: dataFlow.
	flowShape renderBasicShapeIn: canvas.
	flowShape createOwnedElementsWithoutController.
	label := flowShape label.
	label renderIn: canvas.

	initialYPosition := label roassalShape position y.
	dataFlow name: 'Order Processing Stream'.
	label updateRenderFromModel.
	afterTextYPosition := label roassalShape position y.

	"In red phase, this fails because position does not update on text extent change (differs by 8.17 pt)"
	self
		assert: (afterTextYPosition - initialYPosition) abs > 5
		description: 'Label position must automatically adjust when text extent changes'
]
