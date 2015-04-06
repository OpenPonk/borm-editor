accessing - icons
dataFlow16Icon
	"Private - Generated method"
	^icons 
			at: #dataFlow16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self dataFlow16IconContents readStream) ].