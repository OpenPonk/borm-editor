"
I am a unit test class verifying the behavior of OPBormTransitionController, testing correct sequential flow connections between process nodes.
"
Class {
	#name : 'OPBormTransitionControllerTest',
	#superclass : 'OPBormRelationshipControllerTest',
	#category : 'OpenPonk-BormEditor-Tests-Controllers',
	#package : 'OpenPonk-BormEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPBormTransitionControllerTest class >> diagramElementClass [

	^ BormTransitionShape
]

{ #category : 'initialization' }
OPBormTransitionControllerTest >> assignModelSource [

	super assignModelSource.
	model source addTransition: model
]

{ #category : 'initialization' }
OPBormTransitionControllerTest >> assignModelTarget [

	super assignModelTarget.
	model target addTransition: model
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> controllerClass [
	^ OPBormTransitionController
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> modelClass [
	^ BormTransition
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> sourceControllerClass [
	^ OPBormStateController
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> sourceModelClass [
	^ BormState
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> targetControllerClass [
	^ OPBormActivityController
]

{ #category : 'constants' }
OPBormTransitionControllerTest >> targetModelClass [
	^ BormActivity
]

{ #category : 'tests' }
OPBormTransitionControllerTest >> testCanBeTargetForConstraintAndDataFlow [

	| state activity transitionFromState transitionFromActivity constraintController dataFlowController |
	state := BormState named: 'S1'.
	activity := BormActivity named: 'A1'.
	transitionFromState := BormTransition from: state to: activity.
	transitionFromActivity := BormTransition from: activity to: state.
	constraintController := OPBormConstraintController new.
	dataFlowController := OPBormDataFlowController new.

	controller model: transitionFromState.
	self
		assert: (constraintController canVisitTarget: controller)
		description: 'Transition from state without constraint must accept constraint'.
	self deny: (dataFlowController canVisitTarget: controller) description: 'Transition must reject data flow'.

	transitionFromState constraint: (BormConstraint named: 'Existing').
	self
		deny: (constraintController canVisitTarget: controller)
		description: 'Transition that already has a constraint must reject another constraint'.

	controller model: transitionFromActivity.
	self deny: (constraintController canVisitTarget: controller) description: 'Transition from activity must reject constraint'
]
