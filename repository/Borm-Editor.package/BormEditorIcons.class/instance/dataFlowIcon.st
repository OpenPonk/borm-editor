accessing - icons
dataFlowIcon
	"Private - Generated method"
	^icons 
			at: #dataFlowIcon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self dataFlowIconContents readStream) ].