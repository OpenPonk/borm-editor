accessing - icons
personIcon
	"Private - Generated method"

	^ icons
		at: #personIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self personIconContents base64Decoded asByteArray readStream ]