accessing - icons
communication16Icon
	"Private - Generated method"
	^icons 
			at: #communication16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self communication16IconContents readStream) ].