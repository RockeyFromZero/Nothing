//
//  NSString+Extention.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/19.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "NSString+Extention.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#pragma mark - MD5
@implementation NSString(MD5)

- (NSString *)stringToMd5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

@end

#pragma mark - DES
@implementation NSString(DES)
static const NSString *kDesKey = @"nihao";

- (NSString *)stringToBase64 {
    return [self stringToBase64WithKey:nil];
}

- (NSString *)base64ToString {
    return [self base64ToStringWithKey:nil];
}

- (NSString *)stringToBase64WithKey:(const NSString *)key {
    if (self) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        data = [self DES_encryptDESWithKey:data key:key];
        return [data base64EncodedStringWithOptions:0];
    }
    return nil;
}

- (NSData *)DES_encryptDESWithKey:(NSData *)data key:(const NSString *)key {
    return [self DESWithKey:data encryptOrDecrypt:kCCEncrypt key:key];
}

- (NSString *)base64ToStringWithKey:(const NSString *)key {
    if (self) {
        NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:[self DES_formatCheck] options:0];
        NSData *data = [self DES_decryptDESWithKey:decodeData key:key];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string;
    }
    return nil;
}

- (NSData *)DES_decryptDESWithKey:(NSData *)decryptData key:(const NSString *)key {
    return [self DESWithKey:decryptData encryptOrDecrypt:kCCDecrypt key:key];
}

/**
 *  检查 排除 换行 + 回车
 *
 *  @return 排除 换行 + 回车
 */
- (NSString *)DES_formatCheck {
    
    NSString *str_Formated = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    str_Formated = [str_Formated stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str_Formated = [str_Formated stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return str_Formated;
}

/**
 *  DES加密/解密
 *
 *  @param encryptOrDecrypt kCCEncrypt：加密 kCCDecrypt:解密
 *
 *  @return DES加密/解密结果
 */
- (NSData *)DESWithKey:(NSData *)data encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(const NSString *)key {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    const NSString *keyString = key ? key : kDesKey;
    
    [keyString getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(encryptOrDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *returnData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        return returnData;
    }
    
    free(buffer);
    return nil;
}

@end

