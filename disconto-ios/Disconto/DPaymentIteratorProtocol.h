//
//  DPaymentIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPaymentEntity.h"
@protocol DPaymentIteratorProtocol <NSObject>

- (void)sendMobileDataWithCallBack:(void (^)(BOOL result))result;
- (void)sendYandexDataWithCallBack:(void (^)(BOOL result))result;
- (void)sendCardDataWithCallBack:(void (^)(BOOL result))result;
- (NSInteger)modelType;

- (BOOL)setMobileNumber:(NSString *)mobileNumber money:(NSString *)money;
- (void)sendCodeWithCallBack:(void (^)(BOOL result))result;
- (BOOL)setYandexCard:(NSString *)cardNumber money:(NSString *)money;
- (BOOL)setCard:(NSArray<NSString *> *)arrayValues;
- (void)setCode:(NSString *)code;
- (DPaymentEntity *)getEntity;
@end

@protocol DPaymentIteratorProtocolOut <NSObject>

- (void)updateWithNewParams;

@end
