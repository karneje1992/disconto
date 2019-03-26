//
//  DVerificationModel.m
//  Disconto
//
//  Created by user on 11.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DVerificationModel.h"

@implementation DVerificationModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        

        
        if ([dictionary[kServerType] isEqualToString:@"changeEmail"]) {
            
            self.verificationID = [dictionary[kID] integerValue];
            self.emailNew = dictionary[@"new_value"];
            self.emailOld = dictionary[@"old_value"];
            self.verificationType = dictionary[kServerType];
            self.verified = [dictionary[kServerType] boolValue];
            
            
        }else{
            
        
            self.verificationID = [dictionary[kID] integerValue];
            if ([dictionary[@"new_value"] isEqual:[NSNull null]]) {
                
                self.phoneNew = @"";
            }else{
                self.phoneNew = [NSString stringWithFormat:@"%@",dictionary[@"new_value"]];
            }
            
            self.phoneOld = dictionary[@"old_value"];
            self.verificationType = dictionary[kServerType];
            self.verified = [dictionary[kServerType] boolValue];
        }
        self.step = [dictionary[@"step"] integerValue];

    }
    return self;
}

@end
