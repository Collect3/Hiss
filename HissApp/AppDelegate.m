//
//  AppDelegate.m
//  HissApp
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "AppDelegate.h"
#import "PreferencesWindowController.h"
#import "HissSettings.h"
#import "HissEngine.h"
#import "GrowlPropertyListFilePathway.h"
#import "PreferencesViewController.h"
#import "AppConnect.h"

/*!	@defined GROWL_REG_DICT_EXTENSION
 *	@abstract The filename extension for registration dictionaries.
 *	@discussion The GrowlApplicationBridge in Growl.framework registers with
 *	 Growl by creating a file with the extension of .(GROWL_REG_DICT_EXTENSION)
 *	 and opening it in the GrowlHelperApp. This happens whether or not Growl is
 *	 running; if it was stopped, it quits immediately without listening for
 *	 notifications.
 */
#define GROWL_REG_DICT_EXTENSION		@"growlRegDict"


@implementation AppDelegate

@synthesize window = _window;
@synthesize statusBarMenu;
@synthesize statusBarItem;
- (void)dealloc
{
    [super dealloc];
}

- (void)loadCustomFonts {
    NSString *fontFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/Fonts"];
    NSURL *fontsURL = [NSURL fileURLWithPath:fontFilePath];
    if(fontsURL != nil)
    {
        OSStatus status;
        FSRef fsRef;
        CFURLGetFSRef((CFURLRef)fontsURL, &fsRef);
        status = ATSFontActivateFromFileReference(&fsRef, kATSFontContextLocal, kATSFontFormatUnspecified, 
                                                  NULL, kATSOptionFlagsDefault, NULL);
        if (status != noErr)
        {
            NSLog(@"FFailed to acivate fonts!");
        }
    }    
}

- (void) hideStatusBar {
    if (self.statusBarItem) {
        [[NSStatusBar systemStatusBar] removeStatusItem: self.statusBarItem];
        self.statusBarItem = nil;
    }
}

- (void) setupStatusBar {
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    
    [self hideStatusBar];

    NSStatusItem *item = [statusBar statusItemWithLength: NSSquareStatusItemLength];
    [item setImage: [NSImage imageNamed:@"status-icon.png"]];
    [item setHighlightMode:YES];
    [item setMenu: self.statusBarMenu];
    
    self.statusBarItem = item;
}

- (void)preferencesUpdatedMenuBarOption:(NSNotification*)note {
    NSLog(@"preferencesUpdatedMenuBarOption");
    if ([HissSettings sharedInstance].appState.hideInMenuBar) {
        [self hideStatusBar];
    } else {
        [self setupStatusBar];
    }
}

- (void) setupPreferencesWindow {
    preferencesWindowController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindowController"];
    [preferencesWindowController loadFromSettings];    
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[AppConnect sharedInstance] launchedWithAppCode:@"f6701a32118f3d8ebd5ca6355900fac7"];
    [[AppConnect sharedInstance] registerEvent:@"start"];
    
    [[HissSettings sharedInstance] load];
    [self loadCustomFonts];
    
    if ([HissEngine sharedInstance].growlIsRunning) {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"Ok" alternateButton:nil  otherButton:nil informativeTextWithFormat: @"Hiss cannot run while Growl is running. Please stop Growl and restart Hiss."];
        [alert runModal];        
        [[NSApplication sharedApplication] terminate: nil];
    }

    if (![HissSettings sharedInstance].appState.hideInMenuBar) {
        [self setupStatusBar];
    }
    
    [self setupPreferencesWindow];
    
    if ([HissSettings sharedInstance].appState.preferencesWindowShowing) {
        [preferencesWindowController bringToFront];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferencesUpdatedMenuBarOption:) name:kPreferenceViewControllerUpdatedMenuBarOption object:nil];
    
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    NSLog(@"Saving state");
    [preferencesWindowController saveStateToSettings];
    [[HissSettings sharedInstance] save];
}

- (IBAction)actionShowPreferences:(id)sender {
    [preferencesWindowController showWindow: nil];
    [preferencesWindowController bringToFront];
}

- (IBAction)actionToggleActive:(id)sender {
    
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag {
    [self actionShowPreferences: nil];
    return YES;
}

- (BOOL) application:(NSApplication *)theApplication openFile:(NSString *)filename {
	BOOL retVal = NO;
	NSString *pathExtension = [filename pathExtension];
    
	if ([pathExtension isEqualToString:GROWL_REG_DICT_EXTENSION]) {
		//If the auto-quit flag is set, it's probably because we are not the real GHA‚Äîwe're some other GHA that a broken (pre-1.1.3) GAB opened this file with. If that's the case, find the real one and open the file with it.
		BOOL registerItOurselves = YES;

		if (registerItOurselves) {
			//We are the real GHA.
			//Have the property-list-file pathway process this registration dictionary file.
			GrowlPropertyListFilePathway *pathway = [GrowlPropertyListFilePathway standardPathway];
			[pathway application:theApplication openFile:filename];
            retVal = YES;
		} 
	}
    

	return retVal;
}

@end
