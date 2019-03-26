//
//  DNewChangePhoneIterator.h
//  Disconto
//
//  Created by Rostislav on 6/15/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNewChangePhoneIterator : NSObject

@property NSString *phone;
@property NSInteger actionCode;

- (void)chackPhoneStatusCallBack:(void (^)(NSInteger status))status;
- (void)sendNewPhone:(NSString *)phone apiKey:(NSString *)apiKey callBack:(void (^)(NSInteger status))status;
- (void)sendNewCode:(NSString *)phone apiKey:(NSString *)apiKey callBack:(void (^)(NSInteger status))status;
- (void)discardeChangePhonecallBack:(void (^)(NSInteger status))status;
- (void)resendCodeForStatus:(NSInteger)type CallBack:(void (^)(NSInteger status))status;
- (void)sendOldPhone:(NSString *)phone apiKey:(NSString *)apiKey callBack:(void (^)(NSInteger status))status;

@end
