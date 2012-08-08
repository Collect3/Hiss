//
//  HissEngine.m
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "HissEngine.h"
#import "HissSettings.h"
#import "RegisteredApp.h"
#import "HissSettingsRegisteredApps.h"

@implementation HissEngine {
    NSMutableSet *registeredApps;
}

@synthesize isRunning;

// Stores the singleton instance (see below).
static HissEngine *sharedHissEngine = nil;

- (id)init {
    if (self = [super init]){
        isRunning = NO;

        HissSettings *settings = [HissSettings sharedInstance];
        listener = [[NotificationListener alloc] init];
        listener.onAppRegistered = ^(RegisteredApp *app) {
            [settings.registeredApps registerApp:app];
        };
        
        if (settings.appState.engineRunning) {
            [self start];
        }        
    }
    return self;
}

- (void)_saveSettings {
    [HissSettings sharedInstance].appState.engineRunning = isRunning;
    [[HissSettings sharedInstance] save];
}

- (BOOL)growlIsRunning {
    return listener.growlIsRunning;
}

- (void)start {
    listener.listening = YES;
    isRunning = YES;
    [self _saveSettings];
}

- (void)stop {
    listener.listening = NO;
    isRunning = NO;
    [self _saveSettings];    
}


#pragma mark -
#pragma mark Singleton Methods
#pragma mark -

#ifndef __clang_analyzer__ //suppress anaylzer false positions
+ (HissEngine *)sharedInstance {
    @synchronized(self) {
        if (sharedHissEngine == nil) {
			[[self alloc] init]; // assignment not done here		
        }
    }
    return sharedHissEngine;
}
#endif

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedHissEngine == nil) {
			sharedHissEngine = [super allocWithZone:zone];
            return sharedHissEngine;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount NS_AUTOMATED_REFCOUNT_UNAVAILABLE {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (oneway void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}



@end
