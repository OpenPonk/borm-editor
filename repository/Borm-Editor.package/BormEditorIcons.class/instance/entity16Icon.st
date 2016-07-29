accessing - icons
entity16Icon
	"Private - Generated method"
	^icons 
			at: #entity16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self entity16IconContents readStream) ].