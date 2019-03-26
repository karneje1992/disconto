//
//  DMoneyCellIterator.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMoneyCellIteratorProtocol.h"

@interface DMoneyCellIterator : NSObject<DMoneyCellIteratorProtocol>

@property (nonatomic) NSString *money;
@property float comision;
@property CGFloat min;
@property CGFloat max;
@property CGFloat myMoney;

- (instancetype)initWithComision:(float)comision minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue;
@end
