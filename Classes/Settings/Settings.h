//
//  Settings.h
//  RCH
//
//  Created by David Fumberger on 17/01/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject {
    NSMutableDictionary *classes;
    NSMutableArray *classNames;
}
@property (nonatomic, retain) NSMutableDictionary *classes;
+ (Settings *)sharedInstance;
- (void)load;
- (void)save;
@end
