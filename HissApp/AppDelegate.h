//
//  AppDelegate.h
//  HissApp
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PreferencesWindowController.h"
@interface AppDelegate : NSObject <NSApplicationDelegate> {
    PreferencesWindowController *preferencesWindowController;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSMenu   *statusBarMenu;
- (IBAction)actionShowPreferences:(id)sender;
- (IBAction)actionToggleActive:(id)sender;
@end
