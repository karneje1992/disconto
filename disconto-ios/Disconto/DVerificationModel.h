//
//  DVerificationModel.h
//  Disconto
//
//  Created by user on 11.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVerificationModel : NSObject

@property NSInteger verificationID;
@property NSString *emailNew;
@property NSString *emailOld;
@property NSString *verificationType;
@property NSString *phoneOld;
@property NSString *phoneNew;
@property NSInteger step;
@property BOOL verified;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
