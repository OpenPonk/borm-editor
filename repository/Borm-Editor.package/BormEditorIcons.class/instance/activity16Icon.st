accessing - icons
activity16Icon
	"Private - Generated method"

	^ icons
		at: #activity16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self activity16IconContents base64Decoded asByteArray readStream ]