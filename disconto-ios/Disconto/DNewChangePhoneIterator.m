//
//  DNewChangePhoneIterator.m
//  Disconto
//
//  Created by Rostislav on 6/15/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DNewChangePhoneIterator.h"

@interface DNewChangePhoneIterator ()

@property NSInteger veryFaryCode;

@end

@implementation DNewChangePhoneIterator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.phone = @"";
    }
    return self;
}

- (void)chackPhoneStatusCallBack:(void (^)(NSInteger status))status{
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        if (resault.verifications.count) {
            
            [resault.verifications enumerateObjectsUsingBlock:^(DVerificationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (obj.phoneNew.length) {
                    self.phone = obj.phoneNew;
                    status(obj.step+1);
                } else {
                    
                    if (obj.phoneOld.length) {
                        self.phone = [self chackNewPhone];
                        status(obj.step);
                    } else {
                        
                        status(0);
                    }
                }
                
                self.veryFaryCode = obj.verificationID;
            }];
        } else {
            
            if (resault.userPhone.length) {
                
                self.phone = resault.userPhone;
                status(0);
            }else{
   
                status(0);   
            }

        }
    }];
    
}

- (void)sendNewPhone:(NSString *)phone apiKey:(NSString *)apiKey callBack:(void (^)(NSInteger status))status{

    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"phone":phone, @"id":@(self.veryFaryCode)} andAPICall:apiKey withCallBack:^(BOOL success, NSDictionary *resault) {
        if (success) {
            [self saveNewPhoneLacal:phone];
            NSDictionary *responseList = resault[@"data"];
            
            self.veryFaryCode = [responseList[@"verification_id"] integerValue];
            
            self.phone = resault[@"phone"];
            status(3);
            
        } else {
           // status(-2);
        }
    }];
}

- (void)sendOldPhone:(NSString *)phone apiKey:(NSString *)apiKey callBack:(void (^)(NSInteger status))status{
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"phone":phone, @"id":@(self.veryFaryCode)} andAPICall:apiKey withCallBack:^(BOOL success, NSDictionary *resault) {
        if (success) {
            [self saveNewPhoneLacal:phone];
            NSDictionary *responseList = resault[@"data"];
            
            self.veryFaryCode = [responseList[@"verification_id"] integerValue];
            
            self.phone = resault[@"phone"];
            if ([responseList[@"step2"] boolValue]) {
                
                status(2);
            } else {
                
                status(1);
            }            
        }else{
        
           // status(-2);
        }
    }];
}

- (void)sendNewCode:(NSString *)phone apiKey:(NSString *)apiKey callBack:(void (^)(NSInteger status))status{
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"code":phone, @"id":@(self.veryFaryCode)} andAPICall:apiKey withCallBack:^(BOOL success, NSDictionary *resault) {
        if (success) {
            
            
            if (resault[@"data"][@"step2"]) {
                
                status(2);
            } else {
                status(10);
            }

        }else{
        
         //   status(-2);
        }
    }];
}

- (void)discardeChangePhonecallBack:(void (^)(NSInteger status))status{

    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"id":@(self.veryFaryCode)} andAPICall:@"/users/change/delete" withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            status(0);
        } else {
            
           // status(-2);
        }
    }];
}

- (void)resendCodeForStatus:(NSInteger)type CallBack:(void (^)(NSInteger status))status{

    //@"/users/phone/resend/new"
    NSString *key = @"";
    
    switch (type) {
        case 0:
            key = @"old";
            break;
            
        default:
            key = @"new";
            break;
    }

    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"id":@(self.veryFaryCode)} andAPICall:[NSString stringWithFormat:@"/users/phone/resend/%@", key] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            status(type);
        }else{
        
          //  status(-2);
        }
    }];
}

- (void)saveNewPhoneLacal:(NSString *)phone{

    self.phone = phone;
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"newPhone"];
}

- (NSString *)chackNewPhone{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"newPhone"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"newPhone"];
    } else {
        return self.phone;
    }
}
@end
