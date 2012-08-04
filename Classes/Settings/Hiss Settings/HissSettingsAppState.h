//
//  HissSettingsAppState.h
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "SettingsObject.h"

@interface HissSettingsAppState : SettingsObject {
    BOOL engineRunning;
    BOOL preferencesWindowShowing;
    NSValue *windowPosition;
    BOOL hideInMenuBar;
}
@property (nonatomic, assign) BOOL engineRunning;
@property (nonatomic, assign) BOOL preferencesWindowShowing;
@property (nonatomic, assign) NSValue *windowPosition;
@property (nonatomic, assign) BOOL hideInMenuBar;
@end
