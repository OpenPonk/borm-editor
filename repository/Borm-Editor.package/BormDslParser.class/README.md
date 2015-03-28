I parse simple BORM DSL.
This is currently primarily for testing purposes (i.e. quick bootstrapping).

Look to DSLParser/DSLModelBuilder tests/examples for more examples.

Each identifier (participant, state, activity) must be prefixed with corresponding letter (i.e. p for participant, s for state, a for activity).

Diagram is composed of multiple participants: 
[ [ [ 
participantId(participantParams){
stateNode(stateParams)
activityNode(activityParams)
stateSource -> activityTarget
activitySource ->> participantOther.activityTarget
}
]]]

For all items (participant, state, activity) the first parameter (if provided) is used as its name; otherwise the identifer is used.

Second (optional) parameter for participant is his type, and third (optional) is his role.

State can have 'initial' and/or 'final' as parameter to denote that it is initial/final state.

Activity can only have name.

-> denotes transition between state/activity.
->> denotes commuinication

Since communcation ends in different participant, the activity identifier must be prefixed with the participants identifier (i.e. aMyActivity ->> pRemoteParticipant.aRemoteActivity)