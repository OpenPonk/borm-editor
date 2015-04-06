accessing - icons
initialIcon
	"Private - Generated method"
	^icons 
			at: #initialIcon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self initialIconContents readStream) ].