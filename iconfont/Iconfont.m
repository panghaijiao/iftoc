//
//  IconFont.m
//  AutoCoding
//
//  Created by AutoCoding on 2017/01/05.
//  Copyright © 2017年 olinone. All rights reserved.
//
      
#import "IconFont.h"
      
@implementation IconFont
      
+ (instancetype)shareInstance {
    static IconFont *iconFont = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iconFont = [IconFont new];
    });
    return iconFont;
}
      
+ (UIFont *)iconFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"iconfont" size:size];
}

- (NSString *)icongouwuche {
    return @"\U0000e604";
}

- (NSString *)iconqiqiu {
    return @"\U0000e605";
}

@end
