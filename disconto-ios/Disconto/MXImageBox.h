//
//  MXImageBox.h
//  MXBannerView
//
//  Created by Meniny on 16/9/7.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MXImage.h"

@interface MXImageBox : NSObject
@property (nonatomic, assign) MXImageType imageType;
@property (nonatomic, strong) NSMutableArray <MXImage *>* _Nonnull imageArray;
- (instancetype _Nullable)initWithImageType:(MXImageType)type source:(NSMutableArray <NSString *>* _Nonnull)source;
@end
