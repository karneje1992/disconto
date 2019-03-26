//
//  DRegistrationModel.m
//  Disconto
//
//  Created by user on 12.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DRegistrationModel.h"

@implementation DRegistrationModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellsArray = @[];
        self.firstPassword = @"";
        self.lastPassword = @"";
        self.cityID = @"";
        self.cityName = @"";
        self.email = @"";
        self.socType =@"";
        self.socID = @"";
    }
    return self;
}

+ (void)registrationFromServerWithModel:(DRegistrationModel *)registrationModel{

    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{kCityID:registrationModel.cityID, kEmail:registrationModel.email, kFirstName:registrationModel.firstName, kLastName:registrationModel.lastName, kPassword:registrationModel.firstPassword} andAPICall:apiRegistration withCallBack:^(BOOL success, NSDictionary *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (success && resault) {
                
                DLoginModel *obj = [DLoginModel new];
                obj.loginValue = registrationModel.email;
                obj.passwordValue = registrationModel.firstPassword;
                [DLoginModel loginWithLoginModel:obj];
            }
        });
    }];
}

+ (void)registrationGETFromServerWithModel:(DRegistrationModel *)registrationModel{
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{kSocID:registrationModel.socID,kSocType:registrationModel.socType,kCityID:registrationModel.cityID, kEmail:registrationModel.email, kFirstName:[NSString stringWithUTF8String:[registrationModel.firstName cStringUsingEncoding:NSUTF8StringEncoding]], kLastName:[NSString stringWithUTF8String:[registrationModel.lastName cStringUsingEncoding:NSUTF8StringEncoding]], kPassword:registrationModel.firstPassword} andAPICall:apiRegistration withCallBack:^(BOOL success, NSDictionary *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (success) {
                
                DLoginModel *obj = [DLoginModel new];
                obj.loginValue = registrationModel.email;
                obj.passwordValue = registrationModel.firstPassword;
                [DLoginModel loginWithLoginModel:obj];
            }
            
        });
    }];
}

@end
