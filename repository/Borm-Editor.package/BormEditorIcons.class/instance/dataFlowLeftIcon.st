accessing - icons
dataFlowLeftIcon
	"Private - Generated method"
	^icons 
			at: #dataFlowLeftIcon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self dataFlowLeftIconContents readStream) ].