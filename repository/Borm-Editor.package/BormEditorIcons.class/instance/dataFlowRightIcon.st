accessing - icons
dataFlowRightIcon
	"Private - Generated method"

	^ icons
		at: #dataFlowRightIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self dataFlowRightIconContents base64Decoded asByteArray readStream ]