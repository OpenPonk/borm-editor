accessing - icons
communication16Icon
	"Private - Generated method"

	^ icons
		at: #communication16Icon
		ifAbsentPut: [ Form
				fromBinaryStream:
					self communication16IconContents base64Decoded asByteArray readStream ]