//
//  Settings.m
//  RCH
//
//  Created by David Fumberger on 17/01/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "Settings.h"
#import "SettingsObject.h"
@implementation Settings
@synthesize classes;
static Settings *sharedSettings = nil;
// Implemented by subclasses
- (void)registerSettingsClasses {

}

- (id)init {
    if (self = [super init]) {
        [self registerSettingsClasses];
    }
    return self;
}

- (void)load {
    classes = [[NSMutableDictionary alloc] init];
    NSLog(@"load ");    
    NSUserDefaults *localDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"load done %@", classes);
    NSDictionary *dataStore = (NSDictionary*)localDefaults;
    
    for (NSString *settingsClassName in classNames) {
        NSLog(@"%@", settingsClassName);
        Class cls = NSClassFromString(settingsClassName);
        
        NSData *data  = [dataStore objectForKey: [cls defaultsKey] ];              
        SettingsObject *obj = nil;
        if (data) {
            obj = [NSKeyedUnarchiver unarchiveObjectWithData: data];
        } else {
            NSLog(@"Creating %@", settingsClassName);
            obj = [[cls alloc] init];
            [obj setupDefaults];
        }
        [classes setObject:obj forKey:settingsClassName];
    }
    
}
- (void)save {
    NSLog(@"save");
    // Archive each one of the top level settings classes
    NSMutableDictionary *dataStore = [[NSMutableDictionary alloc] init];
       
    // Save into the required data stores
    // Data will always be saved locally , and then optionally into iCloud if it is enabled.
    for (NSString *className in [classes allKeys]) {
        Class cls = NSClassFromString(className);
        NSString *key = [cls defaultsKey];

        id object = [classes objectForKey: className];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject: object];                
        NSLog(@"Object %@ Key %@", object, key);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    }
    
    // Syncronise the user defaults and optionally the iCloud data store.
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [dataStore release];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Singleton Methods
#pragma mark -
+ (Settings *)sharedInstance {
    @synchronized(self) {
        if (sharedSettings == nil) {
			[[self alloc] init]; // assignment not done here		
        }
    }
    return sharedSettings;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedSettings == nil) {
			sharedSettings = [super allocWithZone:zone];
            return sharedSettings;  // assignment and return on first allocation
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

- (unsigned long)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (oneway void)release NS_AUTOMATED_REFCOUNT_UNAVAILABLE {
    //do nothing
}

- (id)autorelease {
    return self;
}


@end
