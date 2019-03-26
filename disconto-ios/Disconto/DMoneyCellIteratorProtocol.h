//
//  DMoneyCellIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DMoneyCellIteratorProtocol <NSObject>

- (NSString *)getMoney;
- (void)setMoneyValue:(NSString *)money;
- (float)getComision;
- (CGFloat)getMinValue;
- (CGFloat)getMaxValue;
- (CGFloat)getMyMoney;
@end
