//
//  DCardTableViewCellIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DCardTableViewCellIteratorProtocol <NSObject>

- (void)setCardNumberValue:(NSString *)cardNumber;
- (NSString *)getCardNumber;
@end
