//
//  DPaymentEntity.m
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPaymentEntity.h"

@implementation DPaymentEntity

- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self) {
        
        self.type = type;
        self.money = @"";
        self.code = @"";
        switch (type) {
            case 0:
                [self cardMode];
                
                break;
            case 1:
                [self mobileMode];
                break;
                
            default:
                [self yandexMode];
                break;
        }
    }
    return self;
}

- (void)mobileMode{
    
    self.phoneNumber = @"";
}
- (void)yandexMode{
    
    self.yandexNumber = @"";
}
- (void)cardMode{
    
    self.cardNumber = @"";
    self.firstName = @"";
    self.secondName = @"";
    self.lastName = @"";
    self.pasportNumber = @"";
    self.year = @"";
    self.month = @"";
    self.day = @"";
    self.pasDepartment = @"";
    self.pasDay = @"";
    self.pasMonth = @"";
    self.pasYear = @"";
    self.birthplace = @"";
    self.registrationPlace = @"";
    self.city = @"";
    self.adress = @"";
    self.postIndex = @"";
    self.phoneNumber = @"";
}
@end
