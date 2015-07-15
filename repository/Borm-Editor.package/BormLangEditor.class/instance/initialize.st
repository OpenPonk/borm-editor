initialization
initialize
	super initialize.
	serializer := BormLangSerializer new.
	locked := false