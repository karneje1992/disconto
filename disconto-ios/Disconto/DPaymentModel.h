//
//  DPaymentModel.h
//  Disconto
//
//  Created by user on 20.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPaymentModel : NSObject

@property NSString *commisssionType;
@property BOOL enabled;
@property NSString *paymentID;
@property UIImage *paymenImage;
@property NSString *paymentType;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
