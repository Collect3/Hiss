#import "SettingsObject.h"

@interface RegisteredApp : SettingsObject<NSCopying>

@property (nonatomic, copy, readonly) NSString *appId;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSData *icon;

- (id)initWithGrowlDictionary:(NSDictionary *)dictionary;

@end
