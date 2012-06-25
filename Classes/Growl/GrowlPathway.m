//
//  GrowlPathway.m
//  Growl
//
//  Created by Ingmar Stein on 15.11.04.
//  Copyright 2004-2006 The Growl Project. All rights reserved.
//
// This file is under the BSD License, refer to License.txt for details

#import "GrowlPathway.h"

@implementation GrowlPathway
@synthesize delegate;


- (id) init {
	if ((self = [super init])) {
        
	}
	return self;
}

- (BOOL) registerApplicationWithDictionary:(bycopy NSDictionary *)dict {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self.delegate performSelectorOnMainThread:@selector(registerApplicationWithDictionary:)
											withObject:dict
										 waitUntilDone:NO];
	[pool release];
	return YES;
}

- (oneway void) postNotificationWithDictionary:(bycopy NSDictionary *)dict {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self.delegate performSelectorOnMainThread:@selector(dispatchNotificationWithDictionary:)
											withObject:dict
										 waitUntilDone:NO];
	[pool release];
}

- (bycopy NSString *) growlVersion {
    return @"1.0";
	//return [GrowlApplicationController growlVersion];
}
@end
