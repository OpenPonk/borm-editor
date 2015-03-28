accessing - icons
settingsIcon
	"Private - Generated method"
	^icons 
			at: #settingsIcon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self settingsIconContents readStream) ].