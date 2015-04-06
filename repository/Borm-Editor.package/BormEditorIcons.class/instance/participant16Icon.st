accessing - icons
participant16Icon
	"Private - Generated method"
	^icons 
			at: #participant16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self participant16IconContents readStream) ].