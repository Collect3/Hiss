//
//  NSStringCategories.m
//  WebServerTest
//
//  Created by David Fumberger on 13/02/09.
//  Copyright 2009 collect3. All rights reserved.
//

#import "NSStringCategories.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Categories)

+ (NSString*)stringFromOSStatus:(OSStatus) errCode {
    if (errCode == noErr)
        return @"noErr";
    char message[5] = {0};
    *(UInt32*) message = CFSwapInt32HostToBig(errCode);
    return [NSString stringWithCString:message encoding:NSASCIIStringEncoding];
}

- (NSString*)stringByDeletingFirstCharacter {
	return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:@""];	    
}
- (NSString*)capitalizeFirstCharacter {
	return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] uppercaseString]];	
}
- (NSString*)lowercaseFirstCharacter {
	return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] lowercaseString]];	
}

- (BOOL)isFile {
	NSArray *pathComponents = [self pathComponents];
	if ([pathComponents count] == 0) {
		return NO;
	}
	NSString *lastComp = [pathComponents lastObject];
	if ([lastComp isEqualToString:@"/"]) {
		return NO;
	} else {
		return YES;
	}
}

- (BOOL)isHiddenFile {
    NSString *firstFileChar = [[self lastPathComponent] substringToIndex:1];
    if ([firstFileChar isEqualToString:@"."]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString*)fileName {
	NSString *path = [[self pathComponents] lastObject];
	NSArray *comps = [path componentsSeparatedByString:@"."];
	if ([comps count] == 0) return nil;
	return [comps objectAtIndex:0];
}
- (NSString*)fileExtension {
	NSString *path = [[self pathComponents] lastObject];	
	NSArray *comps = [path componentsSeparatedByString:@"."];
	if ([comps count] < 2) return nil;
	return [comps objectAtIndex:1];
}
- (BOOL)containsString:(NSString*)string {
	NSRange r = [self rangeOfString: string];
	return (r.length > 0) ? (YES) : (NO);
}
- (NSString*)firstWord {
	NSArray *comps = [self componentsSeparatedByString:@" "];
	return [comps objectAtIndex:0];
}
- (NSString*)firstLine {
	NSArray *comps = [self componentsSeparatedByString:@"\n"];
	return [comps objectAtIndex:0];
}
- (NSString*)stringByRemovingWhitespace {
	return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)stringAsMD5HexHash {
#if TARGET_IPHONE_SIMULATOR
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
#endif    
	unsigned char digest[16];
	char finaldigest[32];
	int i;
    unsigned long l = [self length] ;
	char bytes[l];
	[self getCString:bytes maxLength: l + 1 encoding:   NSUTF8StringEncoding ];
	CC_MD5(bytes,(int)l , digest);
	for(i=0;i<16;i++) sprintf(finaldigest+i*2,"%02x",digest[i]);
    return [NSString stringWithCString:finaldigest encoding:NSUTF8StringEncoding];
//	return [NSString stringWithCString:finaldigest length:32];
}

- (NSString*)stringByReplacingHTMLEntities {
	NSString *str = self;
	str = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
	str = [str stringByReplacingOccurrencesOfString:@"&quot;" withString:@"'"];
	str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];	
	str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];	
	str = [str stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];	    
	return str;
}

- (NSString*)truncatedStringOfLength:(NSInteger)maxLength {
	if ([self length] < maxLength - 1) {
		return self;
	}
	maxLength -= 3;
	NSString *newString = [self substringToIndex: maxLength];
	return [NSString stringWithFormat:@"%@...", newString];
}

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfFirstWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]];
    if (rangeOfFirstWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringFromIndex:rangeOfFirstWantedCharacter.location];
}

- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters {
    return [self stringByTrimmingLeadingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringToIndex:rangeOfLastWantedCharacter.location+1]; // non-inclusive
}

- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters {
    return [self stringByTrimmingTrailingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
