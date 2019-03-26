//
//  ValidatorValues.h
//  Disconto
//
//  Created by Ross on 5/13/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValidatorValues : NSObject

+ (BOOL)validateEmail:(NSString *)candidate;
+ (BOOL)validatePhoneNumber:(NSString *)phoneNumber;
+ (BOOL)validatePassword:(NSString *)password;
+ (BOOL)urlConnectionSucsess:(NSURL *)url;
+ (void)mailExist:(NSString *)mail callBack:(void (^)(BOOL))callBack;
@end
