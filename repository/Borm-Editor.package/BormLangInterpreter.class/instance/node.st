accessing
node
	^ super node
		map: [ :n :comms :trans | 
			trans
				do: [ :each | 
					each source: n.
					n addTransition: each ].
			incompleteTransitions addAll: trans.

			comms
				do: [ :each | 
					each sender: n.
					n send: each ].
			incompleteCommunications addAll: comms.
			n ]