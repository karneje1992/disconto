//
//  DPaymentModel.m
//  Disconto
//
//  Created by user on 20.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DPaymentModel.h"

@implementation DPaymentModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.paymentID = dictionary[kID];
        self.paymenImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dictionary[@"image"]]]]];
        self.paymentType = [NSString stringWithFormat:@"%@",dictionary[kServerType]];
        self.commisssionType = [NSString stringWithFormat:@"%@",dictionary[@"commission_type"]];
        self.enabled = [dictionary[@"commission_type"] boolValue];
    }
    return self;
}
@end
