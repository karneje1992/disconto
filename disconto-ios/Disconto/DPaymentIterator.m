//
//  DPaymentIterator.m
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPaymentIterator.h"

@implementation DPaymentIterator

- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self) {
        
        self.entity = [[DPaymentEntity alloc] initWithType:type];
        self.activeParams = @[].mutableCopy;
        
    }
    return self;
}

- (void)sendMobileDataWithCallBack:(void (^)(BOOL result))result{

    self.activeParams = @{@"what":@"mobile",@"amount":self.entity.money,@"req":@{@"account":[self disablePhoneMask:self.entity.phoneNumber]}}.mutableCopy;
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:self.activeParams andAPICall:@"/payment/make" withCallBack:^(BOOL success, NSDictionary *resault) {
        
        result(success);
    }];
    
}

- (void)sendYandexDataWithCallBack:(void (^)(BOOL result))result{
    
    self.activeParams = @{@"what":@"yandex",@"amount":self.entity.money,@"req":@{@"account":self.entity.yandexNumber}}.mutableCopy;
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:self.activeParams andAPICall:@"/payment/make" withCallBack:^(BOOL success, NSDictionary *resault) {
        
        result(success);
    }];
}

- (void)sendCardDataWithCallBack:(void (^)(BOOL result))result{
    
    self.activeParams = @{@"what":@"cards",
                          @"amount":self.entity.money,
                          @"req":
  @{@"account":self.entity.cardNumber,
    @"birthDate":[NSString stringWithFormat:@"%@.%@.%@",self.entity.day,
                  self.entity.month,self.entity.year],
    @"address":self.entity.adress,
    @"birthPlace":self.entity.birthplace,
    @"city":self.entity.city,
    @"docIssueDay":self.entity.pasDay,
    @"docIssueMonth":self.entity.pasMonth,
    @"docIssueYear":self.entity.pasYear,
    @"docIssuedBy":self.entity.pasDepartment,
    @"docNumber":self.entity.pasportNumber,
    @"firstname":self.entity.firstName,
    @"lastname": self.entity.lastName,
    @"middlename": self.entity.secondName,
    @"postcode":self.entity.postIndex,
    @"smsPhoneNumber": self.entity.phoneNumber}
                          }.mutableCopy;
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:self.activeParams andAPICall:@"/payment/make" withCallBack:^(BOOL success, NSDictionary *resault) {
        
        result(success);
    }];
}

- (void)setCode:(NSString *)code{

    self.entity.code = code;
}

- (void)sendCodeWithCallBack:(void (^)(BOOL result))result{
    
    NSMutableDictionary *finalDictionary = @{}.mutableCopy;
    [finalDictionary addEntriesFromDictionary:self.activeParams];
    [finalDictionary addEntriesFromDictionary:@{@"code":self.entity.code}];
//    [finalDictionary setObject:[finalDictionary objectForKey:@"points"] forKey:@"amount"];
//    [finalDictionary removeObjectForKey:@"points"];
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:finalDictionary andAPICall:@"/payment/make" withCallBack:^(BOOL success, NSDictionary *resault) {
        
        result(success);
    }];
}

- (NSInteger)modelType{

    return self.entity.type;
}

- (BOOL)chackValues:(NSString *)firstValue lastValue:(NSString *)lastValue{

    return firstValue.length && lastValue.length;
}

- (BOOL)setCard:(NSArray<NSString *> *)arrayValues{

    [arrayValues enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (idx) {
            case 0:
                
                self.entity.money = [self disableCardMask:obj];
                break;
            case 1:
                
                self.entity.cardNumber = [self disableCardMask:obj];
                break;
            case 2:
                
                self.entity.phoneNumber = [self disablePhoneMask:obj];
                break;
            case 3:
                
                self.entity.firstName = obj;
                break;
            case 4:
                
                self.entity.lastName = obj;
                break;
              
            case 5:
                
                self.entity.secondName = obj;
                break;
                
            case 6:
                
                self.entity.pasDay = obj;
                break;
            case 7:
                
                self.entity.pasMonth = obj;
                break;
            case 8:
                
                self.entity.pasYear = obj;
                break;
            case 9:
                
                self.entity.birthplace = obj;
                break;
            case 10:
                
                self.entity.day = obj;
                break;
            case 11:
                
                self.entity.month = obj;
                break;
            case 12:
                
                self.entity.year = obj;
                break;
            case 13:
                
                self.entity.pasDepartment = obj;
                break;
            case 14:
                
                self.entity.city = obj;
                break;
//            case 15:
//                
//                self.entity.registrationPlace = obj;
//                break;
            case 15:
                
                self.entity.adress = obj;
                break;
            case 16:
                
                self.entity.postIndex = obj;
                break;
                case 17:
                self.entity.pasportNumber = obj;
                break;

            default:
                break;
        }
    }];
    
    return arrayValues.count == 18;
}

- (BOOL)setMobileNumber:(NSString *)mobileNumber money:(NSString *)money{

    BOOL isCountry = [mobileNumber rangeOfString:@"+7"].location == NSNotFound;
    NSString *phone = mobileNumber;
    
    if (mobileNumber.length == 10 && isCountry) {
       
        phone = [NSString stringWithFormat:@"+7%@",mobileNumber];
    }
    
    if (phone.length != 12) {
        SHOW_MESSAGE(@"", @"Некорректрный номер телефона!")
        return NO;
    } else {
        
        if ([money integerValue] < self.entity.minValue || [money integerValue] > self.entity.maxValue) {
            
            NSString *message = [NSString stringWithFormat:@"Сумма вывода дожна быть от %@ до %@",@(self.entity.minValue), @(self.entity.maxValue)];
            SHOW_MESSAGE(@"", message);
            return NO;
        } else {
            
            self.entity.phoneNumber = phone;
            self.entity.money = [NSString stringWithFormat:@"%@",money];
            
            return YES;
        }
    }
   
}

- (BOOL)setYandexCard:(NSString *)cardNumber money:(NSString *)money{

    self.entity.money = money;
    return self.entity.money.length && [self disableCardMask:cardNumber].length;
}

- (DPaymentEntity *)getEntity{

    return _entity;
}

- (NSString *)disableCardMask:(NSString *)cardNumberWithMask{

    NSString *string = [cardNumberWithMask stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.entity.yandexNumber = string;
    return self.entity.yandexNumber;
}

- (NSString *)disablePhoneMask:(NSString *)phone{

    NSString *string = [phone stringByReplacingOccurrencesOfString:@"+7" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return string;
}

- (void)setNewParams:(NSDictionary *)params{

    self.activeParams = params.mutableCopy;


    if ([params[@"what"] isEqualToString:@"mobile"]) {
        
        [self.entity mobileMode];
        [self setMobileNumber:params[@"account"] money:params[@"amount"]];
    } else if([params[@"what"] isEqualToString:@"yandex"]){
        
        [self.entity yandexNumber];
        [self setYandexCard:params[@"account"] money:params[@"amount"]];
    }else{
    
        [self.entity cardMode];
        [self parseCurentCardDictionary:params[@"req"] money:params[@"amount"]];
    }
    
    [self.delgate updateWithNewParams];
}

- (void)parseCurentCardDictionary:(NSDictionary *)cardDictionary money:(NSString *)money{

    self.entity.money = money;
    
    [cardDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:@"account"]) {
            self.entity.cardNumber = obj;
            
        } else if ([key isEqualToString:@"address"]){
            
            self.entity.adress = obj;
        }else if ([key isEqualToString:@"birthPlace"]){
        
            self.entity.birthplace = obj;
        }else if ([key isEqualToString:@"city"]){
        
            self.entity.city = obj;
        }else if ([key isEqualToString:@"docIssueDay"]){
            
            self.entity.pasDay = obj;
        }else if ([key isEqualToString:@"docIssueMonth"]){
            
            self.entity.pasMonth = obj;
        }else if ([key isEqualToString:@"docIssueYear"]){
            self.entity.pasYear = obj;
        }else if ([key isEqualToString:@"docIssuedBy"]){
            _entity.pasDepartment = obj;
        }else if ([key isEqualToString:@"docNumber"]){
            
            _entity.pasportNumber = obj;
        }else if ([key isEqualToString:@"firstname"]){
            
            _entity.firstName = obj;
        }else if ([key isEqualToString:@"lastname"]){
            _entity.lastName = obj;
        }else if ([key isEqualToString:@"middlename"]){
            _entity.secondName = obj;
        }else if ([key isEqualToString:@"postcode"]){
            _entity.postIndex = obj;
        }else if ([key isEqualToString:@"smsPhoneNumber"]){
            _entity.phoneNumber = obj;
        }else if ([key isEqualToString:@"birthDate"]){
            
            NSString *stringDate = obj;
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"dd.mm.yyyy"];

            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[formatter dateFromString:stringDate]];
            _entity.day = [NSString stringWithFormat:@"%@",@(components.day)];
            _entity.month = [NSString stringWithFormat:@"%@",@(components.month)];
            _entity.year = [NSString stringWithFormat:@"%@",@(components.year)];
        }
    }];
    
}
@end
