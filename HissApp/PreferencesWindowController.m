//
//  PreferencesWindowController.m
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "PreferencesWindowController.h"
#import "PreferencesViewController.h"
#import "HissSettings.h"
@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    // Load the preference pane     
    PreferencesViewController *vc = [[PreferencesViewController alloc] initWithNibName:@"PreferencesViewController" bundle:nil];
    
    [self.window setContentView: vc.view];
    [self.window setReleasedWhenClosed:NO];    
}

- (void)loadFromSettings {
    HissSettings *settings = [HissSettings sharedInstance];
    if (settings.appState.preferencesWindowShowing) {
        [self showWindow: nil];
    }
    //if (settings.appState.windowPosition) {
    //    [self.window setFrameOrigin: [settings.appState.windowPosition pointValue]];
    //} else {
    //    [self.window center];
    //}
}

- (void)saveStateToSettings {
    HissSettings *settings = [HissSettings sharedInstance];
    settings.appState.preferencesWindowShowing = [self.window isVisible];
    settings.appState.windowPosition = [NSValue valueWithPoint: self.window.frame.origin];
    [settings save];
}

- (void)windowWillClose:(NSWindow*)window {
    NSLog(@"Window will close!");
    [self saveStateToSettings];
}

- (void)bringToFront {
    [self.window setLevel: NSMainMenuWindowLevel - 1];
    [self.window makeKeyWindow];    
}

//- (void)windowDidLoad
//{
//    [super windowDidLoad];
//
//    // Load the preference pane path
//    NSString *bundlePath = [[NSBundle mainBundle]
//                            pathForResource: @"Hiss" ofType: @"prefPane"
//                            inDirectory: @""];
//
//    // Load the preference pane     
//    NSBundle *prefBundle = [NSBundle bundleWithPath: bundlePath];
//    Class prefPaneClass = [prefBundle principalClass];
//    NSPreferencePane *prefPaneObject = [[prefPaneClass alloc]
//                                        initWithBundle:prefBundle];     
//
//    // Create the preference pane
//    if ( [prefPaneObject loadMainView] ) {
//        [prefPaneObject willSelect];
//        NSView *prefView = [prefPaneObject mainView];
//        /* Add view to window */
//        [prefPaneObject didSelect];
//        [self.window setContentView: prefPaneObject.mainView];        
//    } else {
//        /* loadMainView failed -- handle error */
//    }    
//    
//}

@end
