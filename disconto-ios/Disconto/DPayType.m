//
//  DPayType.m
//  Disconto
//
//  Created by user on 30.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DPayType.h"

@implementation DPayType

+ (void)getPayWithCallBack:(void (^)(NSArray<DPayType *> *resault,float pending,float balance))callBack{
    
    __block  NSMutableArray *array = @[].mutableCopy;
    __block float pending = 0;
    __block float balance = 0;
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",kGetMoney] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            
            NSDictionary *paymentList = resault[kServerData];
            [paymentList enumerateKeysAndObjectsUsingBlock:^(NSString* key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([key isEqualToString:@"can"]) {
                    
                    if (![obj boolValue]) {
                        
                        callBack(@[],0,0);
                        return ;
                    }
                }
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *singlePayList = obj;
                    [singlePayList enumerateKeysAndObjectsUsingBlock:^(NSString* keyPay, id  _Nonnull objPay, BOOL * _Nonnull stopPay) {
                        
                        DPayType *pay = [DPayType new];
                        pay.moneyType = keyPay;
                        pay.commission = [objPay[@"commission"] floatValue];
                        pay.payEnabled = [objPay[@"enabled"] boolValue];
                        pay.payMin = [objPay[@"min"] floatValue];
                        pay.payMax = [objPay[@"max"] floatValue];
                        pay.payments = @[].mutableCopy;
                        pay.iconUrl = objPay[@"image"];
                        pay.title = objPay[@"title"];
                        pay.iconString = objPay[@"icon"];
                        
                        if ([pay.moneyType isEqualToString:@"cards"]) {
                            
                            pay.payType = cardPay;
                            
                        }else if ([pay.moneyType isEqualToString:@"mobile"]){
                            
                            pay.payType = phonePay;
                        }else if ([pay.moneyType isEqualToString:@"yandex"]){
                            
                            pay.payType = electroPay;
                        }
                        
                        if (pay.payEnabled)
                            [array addObject:pay];
                        
                    }];
                    
                    
                } else {
                    
                    if ([key isEqualToString:@"balance"]) {
                        
                        balance = [obj floatValue];
                    } else if ([key isEqualToString:@"balance"]){
                        
                        pending = [obj floatValue];
                    }
                }
            }];
            callBack(array,pending,balance);
            
        }else{
            
            callBack(array,pending,balance);
        }
    }];
    
}

- (NSString *)getActivePayWithIndexPath:(NSIndexPath *)indexPath{
    
    return self.payments[indexPath.row].paymentType;
}
@end
