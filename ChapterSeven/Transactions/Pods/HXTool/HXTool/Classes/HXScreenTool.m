//
//  HXScreenTool.m
//  HXTool
//
//  Created by 海啸 on 2017/3/20.
//  Copyright © 2017年 Insofan. All rights reserved.
//

#import "HXScreenTool.h"

@implementation UIScreen(HXTool)
+ (CGFloat )screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat )screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat )scale {
    return [UIScreen mainScreen].scale;
}

@end
