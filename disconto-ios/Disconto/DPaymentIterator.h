//
//  DPaymentIterator.h
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPaymentIteratorProtocol.h"
#import "DPaymentEntity.h"

@interface DPaymentIterator : NSObject<DPaymentIteratorProtocol>

@property DPaymentEntity *entity;
@property NSString *veryID;
@property NSMutableDictionary *activeParams;
- (instancetype)initWithType:(NSInteger)type;
- (void)setNewParams:(NSDictionary *)params;
@property id <DPaymentIteratorProtocolOut> delgate;
@end
