//
//  HissSettings.h
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "Settings.h"
#import "HissSettingsAppState.h"
@interface HissSettings : Settings
@property (nonatomic, readonly) HissSettingsAppState *appState;
+ (HissSettings *)sharedInstance;
@end
