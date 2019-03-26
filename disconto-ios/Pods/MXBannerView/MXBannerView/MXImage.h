//
//  MXImage.h
//  MXBannerView
//
//  Created by Meniny on 16/9/7.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MXImageTypeLocal = 0,
    MXImageTypeNetwork,
} MXImageType;

@interface MXImage : NSObject
@property (nonatomic, assign) MXImageType imageType;
@property (nonatomic, copy) NSString * _Nullable imageName;
@property (nonatomic, copy) NSString * _Nullable imageURL;
@end
