accessing - icons
entity16Icon
	"Private - Generated method"

	^ icons
		at: #entity16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self entity16IconContents base64Decoded asByteArray readStream ]