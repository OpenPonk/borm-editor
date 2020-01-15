accessing - icons
dataFlowLeftIcon
	"Private - Generated method"

	^ icons
		at: #dataFlowLeftIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self dataFlowLeftIconContents base64Decoded asByteArray readStream ]