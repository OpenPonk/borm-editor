accessing - icons
dataFlow16Icon
	"Private - Generated method"

	^ icons
		at: #dataFlow16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self dataFlow16IconContents base64Decoded asByteArray readStream ]