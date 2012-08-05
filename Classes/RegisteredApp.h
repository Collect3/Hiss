#import "SettingsObject.h"

@interface RegisteredApp : SettingsObject<NSCopying>

@property (nonatomic, copy, readonly) NSString *appId;
@property (nonatomic, copy, readonly) NSString *name;

- (id)initWithGrowlDictionary:(NSDictionary *)dictionary;

@end
