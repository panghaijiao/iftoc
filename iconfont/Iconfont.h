//
//  IconFont.h
//  AutoCoding
//
//  Created by AutoCoding on 2017/01/05.
//  Copyright © 2017年 olinone. All rights reserved.
//
      
#import <Foundation/Foundation.h>
      
#define theIconFont [IconFont shareInstance]
      
@interface IconFont : NSObject
      
+ (instancetype)shareInstance;
      
+ (UIFont *)iconFontWithSize:(CGFloat)size;
      
@property (readonly) NSString *icongouwuche;

@property (readonly) NSString *iconqiqiu;

@end
