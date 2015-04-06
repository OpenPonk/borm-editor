accessing - icons
systemIcon
	"Private - Generated method"
	^icons 
			at: #systemIcon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self systemIconContents readStream) ].