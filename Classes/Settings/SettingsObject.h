//
//  SettingsObject.h
//  RCH
//
//  Created by David Fumberger on 17/01/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsObject : NSObject
+ (NSString*)defaultsKey;
- (void)setupDefaults;
- (NSArray*)savedProperties;
@end
