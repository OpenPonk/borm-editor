accessing - icons
organizationIcon
	"Private - Generated method"

	^ icons
		at: #organizationIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self organizationIconContents base64Decoded asByteArray readStream ]