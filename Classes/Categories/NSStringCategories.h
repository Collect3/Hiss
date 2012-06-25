//
//  NSStringCategories.h
//  WebServerTest
//
//  Created by David Fumberger on 13/02/09.
//  Copyright 2009 collect3. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Categories)
+ (NSString*)stringFromOSStatus:(OSStatus) errCode;
- (BOOL)isFile;
- (BOOL)isHiddenFile;
- (BOOL)containsString:(NSString*)string;
- (NSString*)firstWord ;
- (NSString*)firstLine;
- (NSString*)stringByRemovingWhitespace;
- (NSString *)stringAsMD5HexHash;
- (NSString*)capitalizeFirstCharacter;
- (NSString*)lowercaseFirstCharacter;
- (NSString*)stringByReplacingHTMLEntities;
- (NSString*)truncatedStringOfLength:(NSInteger)length;
- (NSString*)stringByDeletingFirstCharacter;

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters;
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters;
@end
