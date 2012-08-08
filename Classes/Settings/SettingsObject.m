//
//  SettingsObject.m
//  RCH
//
//  Created by David Fumberger on 17/01/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import "SettingsObject.h"

@implementation SettingsObject

// Can be overridden to not tie directly to class name.
+ (NSString*)defaultsKey {
    return NSStringFromClass([self class]);
}

// Implemented by sub classes
- (NSArray*)savedProperties {
    return nil;
}

// Implemented by sub classes
- (void)setupDefaults {
    
}

- (void) encodeWithCoder: (NSCoder *)coder {
    NSArray *props = [self savedProperties];
    for (NSString *propertyName in props) {
        id obj = [self valueForKey: propertyName];
        [coder encodeObject: obj forKey: propertyName];
    }
}

- (id) initWithCoder:(NSCoder *)coder {
	if (self = [super init]) {
        [self setupDefaults];
        NSArray *props = [self savedProperties];
        for (NSString *propertyName in props) {
            id obj = [coder decodeObjectForKey: propertyName];
            if (obj != nil) {
                [self setValue:obj forKey:propertyName];
            }
        }
	}
	return self;
}

@end
