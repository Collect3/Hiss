//
//  Hiss.m
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "PreferencesViewController.h"
#import "HissEngine.h"
#import "StartAtLogin.h"
#include <QuartzCore/QuartzCore.h>
#import "NSButton+Style.h"
@interface PreferencesViewController()
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

- (IBAction)actionWeb:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"http://collect3.com.au"]];
}

- (IBAction)actionEmail:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"mailto:support@collect3.com.au?subject=Hiss"]];    
}

- (IBAction)actionTwitter:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"http://twitter.com/collect3"]];        
}


@end
