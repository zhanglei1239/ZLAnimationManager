//
//  ZLUIImage.m
//  TexasPoker-iOS
//
//  Created by zhanglei on 14-4-24.
//  Copyright (c) 2014年 Candy. All rights reserved.
//
#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isRetina [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale > 1
#define iPadRetina UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale > 1
#import "ZLUIImage.h"

@implementation ZLUIImage
+(ZLUIImage *)zlImageNamed:(NSString *)name{
    NSString *path;
    if (isRetina&&iPad) {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_2",name] ofType:@"png"];
    }else{
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    }
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return  (ZLUIImage *)image;
}
@end
