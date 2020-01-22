Class {
	#name : #OPBormSimulator,
	#superclass : #Object,
	#instVars : [
		'diagramController',
		'states'
	],
	#category : #'OpenPonk-BormEditor-Simulator'
}

{ #category : #specs }
OPBormSimulator class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | 
					row
						add: #inputLabel;
						add: #input width: 250 ] height: 25;
		newRow: [ :row | 
					row
						add: #startButton;
						add: #stopButton;
						add: #resetButton ]
			height: self toolbarHeight;
		newRow: [ :row | row add: #letterPanel ] height: self toolbarHeight;
		newRow: [ :row | 
					row
						add: #backButton;
						add: #nextButton;
						newColumn: [ :col |  ] ]
			height: self toolbarHeight;
		newRow: [ :row |  ];
		yourself
]

{ #category : #accessing }
OPBormSimulator >> controllerForModel: aModel [
	^ diagramController controllerForModel: aModel
]

{ #category : #accessing }
OPBormSimulator >> diagramController: aController [
	diagramController := aController
]

{ #category : #shapes }
OPBormSimulator >> documentShape [
	^ RTSVGPath new
		path:
			'M 32.933594 -0.025390625 C 31.511579 -0.018751069 30.078369 0.06196686 28.693359 0 C 21.935801 0.014008318 15.176595 -0.027544778 8.4199219 0.021484375 C 5.8417188 0.20143396 4.4108136 2.8746759 4.7714844 5.2382812 C 4.779049 23.557342 4.7567167 41.876536 4.7832031 60.195312 C 4.7221184 62.863346 7.4670893 64.317361 9.8320312 64 C 25.081151 63.986012 40.331844 64.027523 55.580078 63.978516 C 58.158415 63.798608 59.589147 61.125329 59.228516 58.761719 C 59.220148 46.009257 59.24409 33.255997 59.214844 20.503906 C 59.039764 18.618329 58.139696 16.756691 56.703125 15.511719 C 51.020551 10.87105 45.39905 6.1506755 39.677734 1.5605469 C 37.64246 0.15753495 35.303619 -0.036456552 32.933594 -0.025390625 z M 9.2421875 2.9824219 C 9.941955 2.9491767 10.74972 3.0999053 11.355469 3.0078125 C 19.282288 3.045131 27.220347 2.9338859 35.140625 3.0644531 C 36.696749 3.8137917 35.901697 5.7991318 36.097656 7.1835938 C 36.148196 10.668966 35.994953 14.16777 36.181641 17.644531 C 36.591287 20.035496 39.116078 21.196761 41.337891 20.888672 C 46.124564 20.915962 50.920285 20.834722 55.701172 20.929688 C 56.873509 23.23857 55.89661 26.462018 56.21875 29.123047 L 56.21875 59.9375 C 56.232572 60.501844 55.730293 61.004058 55.166016 60.990234 C 39.561424 60.976683 23.952386 61.018106 8.3496094 60.970703 C 7.3108907 60.209707 7.9657037 58.591956 7.78125 57.431641 L 7.78125 4.0625 C 7.9513141 3.2336531 8.54242 3.015667 9.2421875 2.9824219 z M 39.611328 5.7558594 C 40.236584 5.8576407 41.151407 7.1553948 41.71875 7.4316406 C 45.503664 10.689647 49.341363 13.897197 53.09375 17.1875 C 53.243416 18.45074 50.939332 17.657339 50.037109 17.880859 C 46.61114 17.827084 43.162177 17.988379 39.75 17.796875 C 38.604087 16.918838 39.296892 15.236453 39.107422 13.96875 L 39.107422 6.1347656 C 39.227682 5.8208174 39.40291 5.7219323 39.611328 5.7558594 z M 15.373047 11.726562 C 13.985629 11.747995 13.044829 13.485499 14.416016 14.466797 C 18.143807 14.65354 21.907198 14.493896 25.648438 14.546875 C 26.842061 14.357024 28.844646 15.152905 29.1875 13.529297 C 29.199563 12.935006 29.25467 12.169819 28.564453 11.910156 C 24.38851 11.723229 20.177678 11.883194 15.988281 11.830078 C 15.777218 11.755939 15.571249 11.723501 15.373047 11.726562 z M 15.162109 21.125 C 13.722938 21.214222 13.053949 23.551094 14.8125 23.953125 L 32.730469 23.953125 C 33.924051 23.763311 35.927216 24.557674 36.269531 22.933594 C 36.336572 22.209857 36.205971 21.22719 35.251953 21.236328 L 15.820312 21.236328 C 15.588096 21.145152 15.367705 21.112254 15.162109 21.125 z M 15.162109 30.529297 C 13.72296 30.618559 13.053927 32.955628 14.8125 33.357422 L 46.666016 33.357422 C 47.859512 33.167552 49.864442 33.963495 50.207031 32.339844 C 50.274013 31.616034 50.141726 30.631508 49.1875 30.640625 L 15.820312 30.640625 C 15.588103 30.549447 15.367702 30.516545 15.162109 30.529297 z M 15.162109 39.935547 C 13.722925 40.024822 13.053971 42.361677 14.8125 42.763672 L 46.666016 42.763672 C 47.859597 42.573858 49.864716 43.368221 50.207031 41.744141 C 50.274036 41.020374 50.141599 40.037758 49.1875 40.046875 L 15.820312 40.046875 C 15.588091 39.955701 15.367707 39.922793 15.162109 39.935547 z M 35.875 49.349609 C 34.487633 49.371024 33.546751 51.106668 34.917969 52.087891 C 38.645762 52.274626 42.409151 52.116945 46.150391 52.169922 C 47.34411 51.980075 49.348065 52.773721 49.691406 51.150391 C 49.700582 50.548594 49.763532 49.803644 49.066406 49.533203 C 44.890438 49.346279 40.679654 49.506239 36.490234 49.453125 C 36.279186 49.378988 36.073195 49.34655 35.875 49.349609 z';
		scale: 0.5;
		color: Color black
]

{ #category : #initialization }
OPBormSimulator >> initialize [
	states := Dictionary new
]

{ #category : #accessing }
OPBormSimulator >> model [
	^ diagramController model
]

{ #category : #steps }
OPBormSimulator >> move: aName from: sourceName to: targetName [
	| from to el fromCtrl toCtrl |
	from := self model @ aName @ sourceName.
	to := self model @ aName @ targetName.
	fromCtrl := self controllerForModel: from.
	toCtrl := self controllerForModel: to.
	el := states at: aName.
	self view addAnimation: (RTLinearMove to: toCtrl figure position during: 1 on: el).
"	self view addAnimation: (RTNopAnimation new waitFor: 1 after: [ el remove ])"
]

{ #category : #shapes }
OPBormSimulator >> personShape [
	^ RTSVGPath new
		path:
			'M 32 0 C 28.162671 -0.17449603 25.395 4.4969855 27.384766 7.7792969 C 29.071434 11.230453 34.496822 11.422522 36.423828 8.0996094 C 38.709807 4.7566218 36.060472 -0.1168394 32 0 z M 31.583984 12.001953 C 27.021177 12.081061 22.448327 14.413672 20.15625 18.441406 C 17.150777 23.290214 16.284193 29.100253 15.767578 34.677734 C 16.380708 38.285163 22.005909 36.547304 21.457031 33.263672 C 21.941207 29.40486 22.666956 25.46394 24.640625 22.056641 C 24.622932 35.13807 24.563064 48.219849 24.607422 61.300781 C 24.672112 63.944928 28.371351 64.92996 29.904297 62.90625 C 31.084325 61.374907 30.448698 59.334414 30.611328 57.548828 L 30.611328 38.931641 L 33.34375 38.931641 C 33.354426 46.418054 33.32201 53.904866 33.359375 61.390625 C 33.534765 64.697733 39.156462 64.37537 38.923828 61.064453 C 38.869202 49.396978 38.996795 37.730608 39.160156 26.064453 C 39.283641 24.813483 38.91439 21.767161 39.369141 21.730469 C 41.615719 25.548732 42.135639 30.027029 42.775391 34.320312 C 43.684651 37.678421 49.450254 36.513314 48.146484 32.929688 C 47.414214 26.338987 45.607492 19.205717 40.363281 14.732422 C 37.887997 12.830255 34.679994 11.967816 31.583984 12.001953 z';
		scale: 0.5;
		color: Color black
]

{ #category : #shapes }
OPBormSimulator >> reset [
	states valuesDo: #remove.
	states removeAll.
	self view signalUpdate.
]

{ #category : #steps }
OPBormSimulator >> send: aFlow from: sourceActivity to: targetActivity [
	| from to el fromCtrl toCtrl |
	from := self model @ sourceActivity.
	to := self model @ targetActivity.
	el := self documentShape element.
	fromCtrl := self controllerForModel: from.
	toCtrl := self controllerForModel: to.
	self view add: el.
	self view signalUpdate.
	el translateTo: fromCtrl figure position.
	self view signalUpdate.
	self view addAnimation: (RTLinearMove to: toCtrl figure position during: 1 on: el).
	self view addAnimation: (RTNopAnimation new waitFor: 1 after: [ el remove ])
]

{ #category : #steps }
OPBormSimulator >> start: aName [
	self start: aName at: ((self model @ aName) nodes detect: #isInitial)
]

{ #category : #steps }
OPBormSimulator >> start: aName at: aNode [
	| participant el fromCtrl node |
	participant := self model @ aName.
	el := self personShape elementOn: participant.
	node := aNode.
	node isString
		ifTrue: [ node := participant @ aNode ].
	fromCtrl := self controllerForModel: node.
	self view add: el.
	self view signalUpdate.
	el translateTo: fromCtrl figure position.
	self view signalUpdate.
	states at: aName put: el
]

{ #category : #steps }
OPBormSimulator >> step1 [
	self start: 'Customer'.
	self move: 'Customer' from: 'wants pizza' to: 'ordering pizza via phone'
]

{ #category : #steps }
OPBormSimulator >> step2 [
	self start: 'Operator' at: 'processing order'.
	self
		send: 'pizza description'
		from: 'Customer::ordering pizza via phone'
		to: 'Operator::processing order'
]

{ #category : #steps }
OPBormSimulator >> step3 [
	self move: 'Customer' from: 'ordering pizza via phone' to: 'waiting'.
	self move: 'Operator' from: 'processing order' to: 'order accepted'
]

{ #category : #steps }
OPBormSimulator >> step4 [
	self start: 'Kitchen' at: 'accepts order'.
	self move: 'Operator' from: 'order accepted' to: 'passes order'.
	self
		send: 'order'
		from: 'Operator::passes order'
		to: 'Kitchen::accepts order'
]

{ #category : #steps }
OPBormSimulator >> step5 [
	self move: 'Operator' from: 'passes order' to: 'order processed'.
	self move: 'Kitchen' from: 'accepts order' to: 'cooking pizza'
]

{ #category : #accessing }
OPBormSimulator >> view [
	^ diagramController view
]
