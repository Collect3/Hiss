//
//  NSButton+Style.h
//  Hiss
//
//  Created by David Fumberger on 19/02/12.
//  Copyright (c) 2012 Collect3 PTY LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSButton (Style)

- (NSColor *)textColor;
- (void)setTextColor:(NSColor *)textColor;
- (void)setTextShadow:(NSShadow *)textShadow;
@end