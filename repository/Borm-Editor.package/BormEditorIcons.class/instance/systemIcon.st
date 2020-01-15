accessing - icons
systemIcon
	"Private - Generated method"

	^ icons
		at: #systemIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self systemIconContents base64Decoded asByteArray readStream ]