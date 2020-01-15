accessing - icons
constraint16Icon
	"Private - Generated method"

	^ icons
		at: #constraint16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self constraint16IconContents base64Decoded asByteArray readStream ]