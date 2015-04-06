accessing - icons
transition16Icon
	"Private - Generated method"
	^icons 
			at: #transition16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self transition16IconContents readStream) ].