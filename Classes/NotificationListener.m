//
//  NotificationListener.m
//  Roar
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "NotificationListener.h"
#import "GrowlApplicationBridgePathway.h"
#import "GrowlPropertyListFilePathway.h"
@interface NotificationListener() 
- (void)installPathways;
@end

@implementation NotificationListener
@synthesize listening;
@synthesize growlIsRunning;
- (id)init {
    if (self = [super init]) {
        pathways = [[NSMutableArray alloc] init];
        
        [self installPathways];
    }
    return self;
}

- (void)addPathway:(GrowlPathway*)pathway {
    pathway.delegate = self;    
    [pathways addObject: pathway];
}

- (void)installPathways {

    GrowlApplicationBridgePathway *applicationBridge = [[GrowlApplicationBridgePathway alloc] init];
    if (applicationBridge) {
        [self addPathway: applicationBridge];
    } else {
        growlIsRunning = YES;
    }
    [applicationBridge release];
    
    
    GrowlPropertyListFilePathway *propertyList = [GrowlPropertyListFilePathway standardPathway];
    if (propertyList) {
        [self addPathway: propertyList];
    }
    
}

- (void)registerApplicationWithDictionary:(NSDictionary*)dictionary {
    NSLog(@"Register Application %@", dictionary);
}

- (BOOL)sendHelperNotification:(NSString*)applicationName title:(NSString*)title description:(NSString*)description {
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *fullPath = [NSString stringWithFormat: @"%@/Contents/Plugins/HissHelper%@.app", bundlePath, [applicationName capitalizedString]];
    
    NSLog(@"Helper App Path %@", fullPath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: fullPath]) {
        NSError *error = nil;
        NSWorkspace *workspace = [NSWorkspace sharedWorkspace];        
        [workspace launchApplicationAtURL:[NSURL fileURLWithPath: fullPath] options:0 configuration:nil error:&error];
        if (error) {
            NSLog(@"Error %@", error);
            return NO;
        }
        return YES;
    } else {
        return NO;
    }
    return NO;                       
}

- (void)dispatchNotificationWithDictionary:(NSDictionary*)dictionary {
    if (!listening) {
        NSLog(@"Not listening.");
        return;
    }
    
    //NSData *iconData = [dictionary objectForKey:@"ApplicationIcon"];
    //NSImage *image  = [[NSImage alloc] initWithData: iconData];
    
    NSString *applicationName = [dictionary objectForKey:@"ApplicationName"];
    //NSString *notificationName = [dictionary objectForKey:@"NotificationName"];    
    NSString *description = [dictionary objectForKey:@"NotificationDescription"];
    //NSString *priority = [dictionary objectForKey:@"NotificationPriority"];
    NSString *title = [dictionary objectForKey:@"NotificationTitle"];
    
    NSLog(@"%@ - %@ %@", applicationName, title, description);
        
    //if (![self sendHelperNotification: applicationName title: title description: description]) {
        NSUserNotification *note =  [[NSUserNotification alloc] init];
        note.title = [NSString stringWithFormat: @"%@ - %@", applicationName, title];
        note.informativeText = description;
        //note.actionButtonTitle = @"ACTION OK";
        [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification: note];        
        [note release];        
    //}
    
}


@end
