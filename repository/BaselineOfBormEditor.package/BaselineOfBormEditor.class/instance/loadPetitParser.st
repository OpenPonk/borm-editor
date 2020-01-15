accessing
loadPetitParser
	"this is solved separatedly by direct loading code because PetitParser does not specify Roassal2 version, which causes conflicts and this is probably only way to use onConflict:"

	Metacello new
		baseline: 'PetitParser';
		repository: 'github://moosetechnology/PetitParser:v2.x.x/src';
		onConflict: [ :err | err useLoaded ];
		load