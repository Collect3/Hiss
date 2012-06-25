//
//  PreferencesWindowController.h
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesWindowController : NSWindowController
- (void)saveStateToSettings;
- (void)loadFromSettings;
- (void)bringToFront;
@end
