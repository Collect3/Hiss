//
//  Hiss.h
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesViewController : NSViewController {
    
    // General Tab
    IBOutlet NSTextField *startStatusText;
    IBOutlet NSButton *startButton;
    IBOutlet NSButton *startAtLoginCheckbox;
    IBOutlet NSImageView *onImage;
    
    IBOutlet NSTextField *descriptionText;
    
    // About Tab
    IBOutlet NSTextField *aboutLineOne;    
    IBOutlet NSTextField *aboutLineTwo;        
}

- (IBAction)actionStart:(id)sender;

- (IBAction)actionWeb:(id)sender;
- (IBAction)actionEmail:(id)sender;
- (IBAction)actionTwitter:(id)sender;
@end
