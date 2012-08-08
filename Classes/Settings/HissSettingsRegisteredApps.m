//
//  HissSettingsRegisteredApps.m
//  Hiss
//
//  Created by Nikolaj Schumacher on 2012-08-07.
//
//

#import "HissSettingsRegisteredApps.h"

#import "RegisteredApp.h"

@interface HissSettingsRegisteredApps()
@property (nonatomic, strong, readonly) NSMutableSet *disabledApps;
@end

@implementation HissSettingsRegisteredApps

@synthesize apps;
@synthesize disabledApps;

- (void)setupDefaults {
    apps = [NSSet new];
    disabledApps = [NSMutableSet new];
}

- (NSArray*)savedProperties {
    return @[@"apps", @"disabledApps"];
}

- (void)registerApp:(RegisteredApp *)app {
    // Only trigger KVO for actual changes.
    if (![self.apps containsObject:app]) {
        self.apps = [self.apps setByAddingObject:app];
    }
}

- (void)setApp:(RegisteredApp *)app enabled:(BOOL)enabled {
    if (enabled) {
        [disabledApps removeObject:app.name];
    } else {
        [disabledApps addObject:app.name];
    }
}

- (BOOL)isEnabledApp:(RegisteredApp *)app {
    return ![disabledApps containsObject:app.name];
}

@end
