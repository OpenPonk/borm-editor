accessing - icons
diagram16Icon
	"Private - Generated method"
	^icons 
			at: #diagram16Icon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self diagram16IconContents readStream) ].