//
//  HissSettingsRegisteredApps.h
//  Hiss
//
//  Created by Nikolaj Schumacher on 2012-08-07.
//
//

#import "SettingsObject.h"

@class RegisteredApp;

@interface HissSettingsRegisteredApps : SettingsObject

@property (nonatomic, copy) NSSet *apps;

- (void)registerApp:(RegisteredApp *)app;

@end
