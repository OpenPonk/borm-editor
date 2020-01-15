accessing - icons
state16Icon
	"Private - Generated method"

	^ icons
		at: #state16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self state16IconContents base64Decoded asByteArray readStream ]