accessing - icons
dataFlowRightIcon
	"Private - Generated method"
	^icons 
			at: #dataFlowRightIcon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self dataFlowRightIconContents readStream) ].