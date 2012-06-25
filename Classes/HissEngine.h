//
//  HissEngine.h
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationListener.h"
@interface HissEngine : NSObject {
    NotificationListener *listener;
    BOOL isRunning;
    BOOL growlIsRunning;
}
@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, readonly) BOOL growlIsRunning;
+ (HissEngine *)sharedInstance;
- (void)start;
- (void)stop;
@end
