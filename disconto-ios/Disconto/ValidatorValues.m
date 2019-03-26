
//
//  ValidatorValues.m
//  Disconto
//
//  Created by Ross on 5/13/16.
//  Copyright © 2016 Disconto. All rights reserved.
//
#import "NetworkManeger.h"
#import "ValidatorValues.h"

@implementation ValidatorValues

+ (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)validatePhoneNumber:(NSString *)phoneNumber{
    
    NSString *userBody = phoneNumber;
    if (userBody != nil) {
        NSError *error = NULL;
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
        NSArray *matches = [detector matchesInString:userBody options:0 range:NSMakeRange(0, [userBody length])];
        if (matches != nil) {
            for (NSTextCheckingResult *match in matches) {
                if ([match resultType] == NSTextCheckingTypePhoneNumber) {
                    return YES;
                }
            }
        }else{
            
            return NO;
        }
    }else{
        
        return NO;
    }
    return NO;
}

+ (BOOL)validatePassword:(NSString *)password{
    
    if (password.length > 3) {
        return YES;
    }else{
        
        return NO;
    }
}

+ (BOOL)urlConnectionSucsess:(NSURL *)url{
    
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

+ (void)mailExist:(NSString *)mail callBack:(void (^)(BOOL))callBack{
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{@"email":mail} andAPICall:@"/users/exists/email" withCallBack:^(BOOL success, NSDictionary *resault) {
        

        if (success) {
            
            callBack(![resault[@"data"][@"count"] integerValue]);
        }
    }];
}
@end
