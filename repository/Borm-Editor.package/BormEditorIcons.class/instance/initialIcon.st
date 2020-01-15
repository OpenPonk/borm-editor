accessing - icons
initialIcon
	"Private - Generated method"

	^ icons
		at: #initialIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self initialIconContents base64Decoded asByteArray readStream ]