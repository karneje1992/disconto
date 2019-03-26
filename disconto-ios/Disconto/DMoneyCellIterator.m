//
//  DMoneyCellIterator.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DMoneyCellIterator.h"

@implementation DMoneyCellIterator

- (instancetype)initWithComision:(float)comision minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue
{
    self = [super init];
    if (self) {
        self.money = @"";
        self.comision = comision;
        self.min = minValue;
        self.max = maxValue;
        self.myMoney = maxValue;
        
        [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
            
            self.myMoney = resault.userPoints;
        }];
    }
    return self;
}
- (NSString *)getMoney{

    return self.money;
}

- (float)getComision{

    return self.comision;
}

- (void)setMoneyValue:(NSString *)money{

    self.money = money;
}

- (CGFloat)getMinValue{

    return self.min;
}
- (CGFloat)getMaxValue{
    

    return self.max;
}

- (CGFloat)getMyMoney{

    return self.myMoney ? self.myMoney : 0;
}
@end
