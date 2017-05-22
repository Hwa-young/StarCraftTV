//
//  AESCrypt.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 25..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "AESCrypt.h"
#import "NSData+CommonCrypto.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"

const Byte ivBytes2[] = { 0x2A, 0x07, 0x72, 0x3B, 0x37, 0x05, 0x1E, 0x01, 0x6E, 0x44, 0x02, 0x33, 0x2A, 0x61, 0x26, 0x3C };

@implementation AESCrypt

+ (NSString *)decrypt:(NSString *)base64EncodedString key:(NSString *)key {
	NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
	NSData *decryptedData = [self AES128DecryptWithData:encryptedData WithKey:key];
	return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSData *)AES128DecryptWithData:(NSData*)data WithKey:(NSString*)key
{
	char keyPtr[kCCKeySizeAES128 + 1];
	bzero(keyPtr, sizeof(keyPtr));
	
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [data length];
	
	size_t bufferSize           = dataLength + kCCBlockSizeAES128;
	void* buffer                = malloc(bufferSize);
	
	size_t numBytesDecrypted    = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
										  kCCAlgorithmAES128,
										  kCCOptionPKCS7Padding,
										  keyPtr, kCCKeySizeAES128,
										  [@"6yhlJ4WF9ZIj6I8n" UTF8String],
										  [data bytes], dataLength,
										  buffer, bufferSize,
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		return [NSMutableData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
	}
	
	free(buffer);
	return nil;
}

@end
