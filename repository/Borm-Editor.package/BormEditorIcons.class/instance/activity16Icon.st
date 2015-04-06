accessing - icons
activity16Icon
	"Private - Generated method"
	^icons 
			at: #activity16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self activity16IconContents readStream) ].