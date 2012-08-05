#import "RegisteredApp.h"

@implementation RegisteredApp

@synthesize appId;
@synthesize name;

- (id)initWithGrowlDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        appId = [[dictionary objectForKey:@"ApplicationId"] copy];
        name = [[dictionary objectForKey:@"ApplicationName"] copy];
    }
    return self;
}

#pragma mark - persistence

- (NSArray*)savedProperties {
    return @[@"appId", @"name"];
}

#pragma mark - copy

- (id)copyWithZone:(NSZone *)zone {
    // immutable
    return self;
}

#pragma mark - equality

- (BOOL)isEqualToRegisteredApp:(RegisteredApp *)registeredApp {
    return [name isEqualToString:registeredApp.name];
}

- (BOOL)isEqual:(id)object {
    return [object isKindOfClass:[RegisteredApp class]]
    && [self isEqualToRegisteredApp:(RegisteredApp *)object];
}

- (NSUInteger)hash {
    return appId.hash;
}

#pragma mark - description

- (NSString *)description {
    return [NSString stringWithFormat:@"[RegisteredApp %@ (%@)]", appId, name];
}

@end
