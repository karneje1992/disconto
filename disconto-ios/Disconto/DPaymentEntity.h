//
//  DPaymentEntity.h
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPaymentEntity : NSObject

@property(nonatomic) NSString *money;
@property(nonatomic) NSString *code;
@property(nonatomic) NSInteger type;
@property(nonatomic) NSInteger minValue;
@property(nonatomic) NSInteger maxValue;
@property(nonatomic) NSString *phoneNumber;
@property(nonatomic) NSString *yandexNumber;
@property(nonatomic) NSString *cardNumber;
@property(nonatomic) NSString *firstName;
@property(nonatomic) NSString *secondName;
@property(nonatomic) NSString *lastName;
@property(nonatomic) NSString *pasportNumber;
@property(nonatomic) NSString *year;
@property(nonatomic) NSString *month;
@property(nonatomic) NSString *day;
@property(nonatomic) NSString *pasDepartment;
@property(nonatomic) NSString *pasDay;
@property(nonatomic) NSString *pasMonth;
@property(nonatomic) NSString *pasYear;
@property(nonatomic) NSString *birthplace;
@property(nonatomic) NSString *registrationPlace;
@property(nonatomic) NSString *city;
@property(nonatomic) NSString *adress;
@property(nonatomic) NSString *postIndex;

@property float comision;

- (instancetype)initWithType:(NSInteger)type;
- (void)mobileMode;
- (void)yandexMode;
- (void)cardMode;

@end

