accessing - icons
oRModel16Icon
	"Private - Generated method"

	^ icons
		at: #oRModel16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self oRModel16IconContents base64Decoded asByteArray readStream ]