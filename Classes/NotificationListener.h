//
//  NotificationListener.h
//  Roar
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrowlPathway.h"

@class RegisteredApp;

@interface NotificationListener : NSObject {
    NSMutableArray *pathways;
    BOOL listening;
    BOOL growlIsRunning;
}
@property (nonatomic, assign) BOOL listening;
@property (nonatomic, assign) BOOL growlIsRunning;
@property (nonatomic, copy) void (^onAppRegistered)(RegisteredApp *);
@property (nonatomic, copy) BOOL (^shouldSendNotification)(NSUserNotification *, RegisteredApp *);

- (void)addPathway:(GrowlPathway*)pathway;
@end
