//
//  Hiss.m
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "PreferencesViewController.h"
#import "HissEngine.h"
#import "HissSettings.h"
#import "HissSettingsRegisteredApps.h"
#import "RegisteredApp.h"
#import "StartAtLogin.h"
#include <QuartzCore/QuartzCore.h>
#import "NSButton+Style.h"

static NSString *const KEY_REGISTERED_APPS = @"apps";
static NSString *const KEY_ENABLED = @"enabled";

NSString *kPreferenceViewControllerUpdatedMenuBarOption = @"kPreferenceViewControllerUpdatedMenuBarOption";

@interface PreferencesViewController()<NSTableViewDataSource, NSTableViewDelegate>
- (void)updateGeneralUI;
- (void)updateAboutUI;
- (void)showOnImage:(BOOL)show animated:(BOOL)animated;
@end

@implementation PreferencesViewController

- (void)loadView {
    [super loadView];
        
    HissEngine *engine = [HissEngine sharedInstance];    
    [self showOnImage: engine.isRunning animated: NO];
    [self updateGeneralUI];  
    [self updateAboutUI];

    [[HissSettings sharedInstance].registeredApps addObserver:self
                                                   forKeyPath:KEY_REGISTERED_APPS
                                                      options:0
                                                      context:nil];
}

- (void)dealloc {
    [[HissSettings sharedInstance].registeredApps removeObserver:self
                                                      forKeyPath:KEY_REGISTERED_APPS];
    [super dealloc];
}

#pragma mark -
#pragma mark General Tab
#pragma mark -
- (void)showOnImage:(BOOL)show animated:(BOOL)animated {
    CABasicAnimation *fade;
    fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat: onImage.layer.opacity];
    fade.toValue = [NSNumber numberWithFloat: (show) ? (1.0) : (0.0) ];
    fade.duration = 0.25;
    [onImage.layer addAnimation:fade forKey:@"fade"];
    onImage.layer.opacity = [fade.toValue floatValue];
}
- (void)updateGeneralUI {
    HissEngine *engine = [HissEngine sharedInstance];    
    if (engine.isRunning) {
        startStatusText.stringValue = @"Hiss is started. Growl notifications will be forwarded to Notification Center.";
        startButton.title = @"Stop";
        //onImage.layer.opacity = 1.0f;
        //[onImage setHidden:NO];
    } else {
        startStatusText.stringValue = @"Hiss is stopped. No Growl notifications will be forwarded to Notification Center.";        
        startButton.title = @"Start";        
        //onImage.layer.opacity = 0.0f; 
        //[onImage setHidden:YES];        
    }
    
    StartAtLogin *start = [[StartAtLogin alloc] init];
    [startAtLoginCheckbox setState:  [start doesStartAtLogin]];
    [start release];
    
    BOOL hideInMenuBar = [HissSettings sharedInstance].appState.hideInMenuBar;
    [showInMenuBarCheckbox setState: !hideInMenuBar];
    
    [startButton setFont: [NSFont fontWithName:@"MyriadPro-Bold" size:18 ]];
    [startButton.cell setImageDimsWhenDisabled: NO];
    [startButton setTextColor: [NSColor colorWithSRGBRed:103.0/255.0f green:103.0/255.0f blue:103.0/255.0f alpha:1.0f]];    
    
    NSShadow* shadow = [[NSShadow alloc] init];    
    [shadow setShadowColor:[NSColor whiteColor]];
    [shadow setShadowOffset:NSMakeSize( 0, 1.0 )];
    [shadow setShadowBlurRadius:0.0];
    [startButton setTextShadow: shadow];            
    [shadow release];
    
    [[startStatusText cell] setBackgroundStyle:NSBackgroundStyleRaised];    
    
    
    startStatusText.font =  [NSFont fontWithName:@"MyriadPro-Regular" size:18 ];
    
    //[startStatusText setTextColor: [NSColor colorWithSRGBRed:103.0/255.0f green:103.0/255.0f blue:103.0/255.0f alpha:1.0f]];
    /*shadow = [[NSShadow alloc] init];    
    [shadow setShadowColor:[NSColor whiteColor]];
    [shadow setShadowOffset:NSMakeSize( 0, 1.0 )];
    [shadow setShadowBlurRadius:0.0];    
    [startStatusText setShadow: shadow];
    [shadow release];*/
    
}

- (void)updateAboutUI {
    //aboutLineOne.font =  [NSFont fontWithName:@"MyriadPro-Bold" size:14 ];
    [[aboutLineOne cell] setBackgroundStyle:NSBackgroundStyleRaised];        
    
    //aboutLineTwo.font =  [NSFont fontWithName:@"MyriadPro-Regular" size:14 ];    
    [[aboutLineTwo cell] setBackgroundStyle:NSBackgroundStyleRaised];        
}

- (IBAction)actionStart:(id)sender {
    NSLog(@"actionStart:");
    HissEngine *engine = [HissEngine sharedInstance];
    if (engine.isRunning) {
        [engine stop];
    } else {
        [engine start];
    }
    [self showOnImage: engine.isRunning animated: YES];
    [self updateGeneralUI];
}

- (IBAction)actionToggleStartAtLogin:(NSButton*)sender {
    StartAtLogin *start = [[StartAtLogin alloc] init];
    [start setStartAtLogin: sender.state ];
    [start release];    
    
    [self updateGeneralUI];
}

- (IBAction)actionToggleShowInMenuBar:(NSButton*)sender {
    [HissSettings sharedInstance].appState.hideInMenuBar = !sender.state;
    [[HissSettings sharedInstance] save];
    
    [self updateGeneralUI];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPreferenceViewControllerUpdatedMenuBarOption object:nil];
}

- (IBAction)actionWeb:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"http://collect3.com.au"]];
}

- (IBAction)actionEmail:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"mailto:support@collect3.com.au?subject=Hiss"]];    
}

- (IBAction)actionTwitter:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"http://twitter.com/collect3"]];        
}

#pragma mark -
#pragma mark Apps Tab
#pragma mark -

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {

    if (object == [HissSettings sharedInstance].registeredApps
        && [keyPath isEqualToString:KEY_REGISTERED_APPS]) {
        [registeredAppsTable reloadData];
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [HissSettings sharedInstance].registeredApps.apps.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {

    NSView *view = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    RegisteredApp *app = [self registeredAppAtIndex:row];

    if ([tableColumn.identifier isEqualToString:KEY_ENABLED]) {
        BOOL enabled = [[HissSettings sharedInstance].registeredApps isEnabledApp:app];
        NSButton *checkbox = (NSButton *)view;
        checkbox.state = enabled ? NSOnState : NSOffState;
        checkbox.action = @selector(appEnabledButtonPressed:);
        checkbox.target = self;
        checkbox.tag = row;
    } else {
        NSTableCellView *cellView = (NSTableCellView *)view;
        cellView.textField.stringValue = [app valueForKey:tableColumn.identifier];
        cellView.imageView.image = [[[NSImage alloc] initWithData:app.icon] autorelease];
    }

    return view;
}

- (RegisteredApp *)registeredAppAtIndex:(NSInteger)index {
    return [[[HissSettings sharedInstance].registeredApps.apps allObjects] objectAtIndex:index];
}

- (void)appEnabledButtonPressed:(NSButton *)sender {
    RegisteredApp *app = [self registeredAppAtIndex:sender.tag];
    [[HissSettings sharedInstance].registeredApps setApp:app enabled:sender.state == NSOnState];
}

@end
