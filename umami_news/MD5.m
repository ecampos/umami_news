//
//  MD5.m
//  umami_news
//
//  Created by Emanuel Campos on 20.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

//MD5 Hasher
// source http://stackoverflow.com/questions/2018550/how-do-i-create-an-md5-hash-of-a-string-in-cocoa

- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}

@end
