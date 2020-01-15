accessing - icons
settingsIcon
	"Private - Generated method"

	^ icons
		at: #settingsIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self settingsIconContents base64Decoded asByteArray readStream ]