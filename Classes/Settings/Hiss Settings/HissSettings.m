//
//  HissSettings.m
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "HissSettings.h"

#import "HissSettingsRegisteredApps.h"

@implementation HissSettings

+ (HissSettings *)sharedInstance {
    return (HissSettings*)[super sharedInstance];
}

- (void)registerSettingsClasses {
    classNames = [[NSMutableArray alloc] initWithObjects: @"HissSettingsAppState",
                  @"HissSettingsRegisteredApps", nil];
}

- (HissSettingsAppState*)appState {
    static NSString *c = @"HissSettingsAppState";
    NSLog(@"Classes %@ %@", self.classes, [self.classes objectForKey:c]);
    return [self.classes objectForKey: c];
}

- (NSSet *)registeredApps {
    static NSString *c = @"HissSettingsRegisteredApps";
    return [self.classes objectForKey:c];
}

@end
