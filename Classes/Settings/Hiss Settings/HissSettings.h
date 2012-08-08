//
//  HissSettings.h
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "Settings.h"
#import "HissSettingsAppState.h"

@class HissSettingsRegisteredApps;

@interface HissSettings : Settings

@property (nonatomic, readonly) HissSettingsAppState *appState;
@property (nonatomic, copy) HissSettingsRegisteredApps *registeredApps;

+ (HissSettings *)sharedInstance;
@end
