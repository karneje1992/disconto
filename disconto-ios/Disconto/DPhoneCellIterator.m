//
//  DPhoneCellIterator.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPhoneCellIterator.h"

@implementation DPhoneCellIterator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.phoneNumber = @"";
        
    }
    return self;
}

- (NSString *)getPhoneNumber{

    return self.phoneNumber;
}

- (void)setPhoneValue:(NSString *)phoneNumber{

    self.phoneNumber = phoneNumber;
}
@end
