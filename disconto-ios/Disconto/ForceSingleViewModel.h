//
//  ForceSingleViewModel.h
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/23/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coupon.h"
#import "DCouponHeaderCell.h"

@interface ForceSingleViewModel : NSObject

@property NSArray *cellsArray;
@property CGFloat headerSize;
@property Coupon *object;

+ (instancetype)singleForceCubeForCoub:(Coupon *)coupon;
- (instancetype)initWithCoupon:(Coupon *)coupon;

- (void)updateCintroller:(UIViewController *)updateController;
@end
