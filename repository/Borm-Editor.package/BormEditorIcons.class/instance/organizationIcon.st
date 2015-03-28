accessing - icons
organizationIcon
	"Private - Generated method"
	^icons 
			at: #organizationIcon
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self organizationIconContents readStream) ].