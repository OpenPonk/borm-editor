navigating
resolvePath: aString
	| url |
	url := XMLURI fromString: aString.
	^ self getDocument: url path