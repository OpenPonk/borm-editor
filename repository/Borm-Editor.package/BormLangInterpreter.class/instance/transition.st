accessing
transition
	^ super transition
		==> [ :arr | [ :from :aParticipant | BormFactory fqnTransitionFrom: from to: arr first in: aParticipant ] ]