//
//  MXImageBox.m
//  MXBannerView
//
//  Created by Meniny on 16/9/7.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import "MXImageBox.h"

@implementation MXImageBox
- (NSMutableArray<MXImage *> *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (instancetype)initWithImageType:(MXImageType)type source:(NSMutableArray<NSString *> *)source {
    self = [super init];
    if (self) {
        [self setImageType:type];
        if (source) {
            for (NSString *string in source) {
                MXImage *image = [MXImage new];
                [image setImageType:type];
                if (type == MXImageTypeLocal) {
                    [image setImageName:string];
                } else {
                    [image setImageURL:string];
                }
                [[self imageArray] addObject:image];
            }
        }
    }
    return self;
}
@end
