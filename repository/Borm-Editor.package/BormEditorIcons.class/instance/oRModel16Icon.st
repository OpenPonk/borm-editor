accessing - icons
oRModel16Icon
	"Private - Generated method"
	^icons 
			at: #oRModel16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self oRModel16IconContents readStream) ].