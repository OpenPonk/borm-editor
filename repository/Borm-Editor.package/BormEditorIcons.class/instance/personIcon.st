accessing - icons
personIcon
	"Private - Generated method"
	^icons 
			at: #personIcon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self personIconContents readStream) ].