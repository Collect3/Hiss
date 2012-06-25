//
//  GrowlNotificationServer.h
//  Growl
//
//  Created by Ingmar Stein on 15.11.04.
//  Copyright 2004-2006 The Growl Project. All rights reserved.
//
// This file is under the BSD License, refer to License.txt for details

#import <Foundation/Foundation.h>

@protocol GrowlNotificationProtocol
- (BOOL) registerApplicationWithDictionary:(bycopy NSDictionary *)dict;
- (oneway void) postNotificationWithDictionary:(bycopy NSDictionary *)notification;
- (bycopy NSString *) growlVersion;
@end

@class GrowlApplicationController;

@interface GrowlPathway : NSObject <GrowlNotificationProtocol> {
    id delegate;
}
@property (nonatomic, retain) id delegate;
@end

@protocol GrowlPathwayDelegate <NSObject>
- (void)registerApplicationWithDictionary:(NSDictionary*)dictionary;
- (void)dispatchNotificationWithDictionary:(NSDictionary*)dictionary;
@end