accessing - icons
state16Icon
	"Private - Generated method"
	^icons 
			at: #state16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self state16IconContents readStream) ].