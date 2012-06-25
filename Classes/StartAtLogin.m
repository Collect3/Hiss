//
//  StartAtLogin.m
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "StartAtLogin.h"

//-----
//Note: !! Note working with sandboxing
// Need to implement something like documented here
// http://www.delitestudio.com/2011/10/25/start-dockless-apps-at-login-with-app-sandbox-enabled/
//----

@implementation StartAtLogin

#pragma mark -
#pragma mark Login 
#pragma mark -
- (void)log:(NSString*)_log {
	NSLog(@"StartAtLogin: %@", _log);
}

- (BOOL)doesStartAtLogin {
	// Some seed data
	//UInt32 seedValue;
	
	// Let's create reference to shared file list
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	
	// Then just pop values from referenced list into array
	//NSArray  *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(loginItems, &seedValue);	
	
	NSString *appPath = [[NSBundle mainBundle] bundlePath];
    	
	LSSharedFileListItemRef itemRef = [self loginItemWithLoginItemReference:loginItems ForPath: appPath];    
    if (itemRef) {
        return YES;
    } else {
        return NO;
    }
}
- (void)removeAppFromLogin:(LSSharedFileListRef)theLoginItemsRefs item:(LSSharedFileListItemRef)itemRef {
	NSLog(@"Removing app from login");
	LSSharedFileListItemRemove(theLoginItemsRefs, itemRef);	
}

- (void)addAppToLoginSandbox:(NSString*)path {
    NSURL *url = [NSURL fileURLWithPath: path];
    // Registering helper app
	if (LSRegisterURL((CFURLRef)url, true) != noErr) {
		NSLog(@"LSRegisterURL failed!");
	}    
}

- (void)addAppToLogin:(LSSharedFileListRef)theLoginItemsRefs path:(NSString*)path {
	NSLog(@"Adding item to startup %@", path);
	// Reference to shared file list
	//LSSharedFileListRef theLoginItemsRefs = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	
	// CFURLRef to the insertable item.
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath: path];
	
	// Actual insertion of an item.
	LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(theLoginItemsRefs, kLSSharedFileListItemLast, NULL, NULL, url, NULL, NULL);
	
	// Clean up in case of success
	if (item) {
		[self log:@"Added item to started"];
		CFRelease(item);	
	} else {
		[self log: [NSString stringWithFormat: @"Couldnt add item to startup. Maybe does exist at ? %@", path]];
	}
}

- (BOOL)string:(NSString*)string1 containsString:(NSString*)string2 {
	NSRange r = [string1 rangeOfString: string2];
	return (r.length > 0) ? (YES) : (NO);
}


- (LSSharedFileListItemRef)loginItemWithLoginItemReference:(LSSharedFileListRef)theLoginItemsRefs ForPath:(NSString*)thePath {
	//BOOL exists = NO;
	UInt32 seedValue;
	NSURL *urlPath = [NSURL fileURLWithPath: thePath];
	
	NSArray  *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(theLoginItemsRefs, &seedValue);  
	for (id item in loginItemsArray) {    
		LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &urlPath, NULL) == noErr) {
			NSString *path = [(NSURL *)urlPath path]; 
			if ([self string: path containsString:thePath]) {
				return itemRef;
			}
		}
		
	};
	return nil;
}
- (void)setStartAtLogin:(BOOL)startAtLogin {
	// Some seed data
	//UInt32 seedValue;
	
	// Let's create reference to shared file list
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	
	// Then just pop values from referenced list into array
	//NSArray  *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(loginItems, &seedValue);	
	
	NSString *appPath = [[NSBundle mainBundle] bundlePath];
	[self log: [NSString stringWithFormat: @"App Path %@", appPath]];

    LSSharedFileListItemRef existingItemRef;
	while((existingItemRef = [self loginItemWithLoginItemReference:loginItems ForPath:appPath])) {
//		[self log: @"Found existing startup item"];
		[self removeAppFromLogin:loginItems item:existingItemRef];
	}
	
	LSSharedFileListItemRef itemRef = [self loginItemWithLoginItemReference:loginItems ForPath: appPath];
	
	// If exists in login but we dont want it there
	if (itemRef && !startAtLogin)  {
		[self log: @"Removing app from startup"];
		[self removeAppFromLogin: loginItems item:itemRef];
        // If not in startup and we want it there
	} else if (startAtLogin && !itemRef) {
		[self log: @"Adding app to startup"];
        //[self addAppToLoginSandbox: appPath];
		[self addAppToLogin: loginItems path:appPath];
	}
}

@end
