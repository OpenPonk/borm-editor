accessing - icons
constraint16Icon
	"Private - Generated method"
	^icons 
			at: #constraint16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self constraint16IconContents readStream) ].