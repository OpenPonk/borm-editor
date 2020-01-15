accessing - icons
participant16Icon
	"Private - Generated method"

	^ icons
		at: #participant16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self participant16IconContents base64Decoded asByteArray readStream ]