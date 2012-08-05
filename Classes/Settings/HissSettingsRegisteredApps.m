//
//  HissSettingsRegisteredApps.m
//  Hiss
//
//  Created by Nikolaj Schumacher on 2012-08-07.
//
//

#import "HissSettingsRegisteredApps.h"

@implementation HissSettingsRegisteredApps

@synthesize apps;

- (void)setupDefaults {
    apps = [NSSet new];
}

- (NSArray*)savedProperties {
    return @[@"apps"];
}

- (void)registerApp:(RegisteredApp *)app {
    // Only trigger KVO for actual changes.
    if (![self.apps containsObject:app]) {
        self.apps = [self.apps setByAddingObject:app];
    }
}


@end
