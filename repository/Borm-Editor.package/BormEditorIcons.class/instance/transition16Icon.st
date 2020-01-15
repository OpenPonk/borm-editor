accessing - icons
transition16Icon
	"Private - Generated method"

	^ icons
		at: #transition16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self transition16IconContents base64Decoded asByteArray readStream ]