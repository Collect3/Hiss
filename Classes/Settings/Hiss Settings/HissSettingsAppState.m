//
//  HissSettingsAppState.m
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "HissSettingsAppState.h"

@implementation HissSettingsAppState
@synthesize engineRunning;
@synthesize preferencesWindowShowing;
@synthesize windowPosition;
@synthesize hideInMenuBar;
- (void)setupDefaults {
    engineRunning = YES;
    preferencesWindowShowing = YES;
    hideInMenuBar = NO;
}


- (NSArray*)savedProperties {
    static NSArray *savedProperties = nil;
    if (savedProperties == nil) {
        savedProperties = [@[@"engineRunning", @"preferencesWindowShowing", @"windowPosition", @"hideInMenuBar"] retain];
    }
    return savedProperties;
}
@end
