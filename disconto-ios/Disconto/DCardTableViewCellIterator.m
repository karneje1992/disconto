//
//  DCardTableViewCellIterator.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DCardTableViewCellIterator.h"

@implementation DCardTableViewCellIterator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cardNumber = @"";
    }
    return self;
}

- (void)setCardNumberValue:(NSString *)cardNumber{

    self.cardNumber = cardNumber;
}

- (NSString *)getCardNumber{

    return self.cardNumber;
}
@end
