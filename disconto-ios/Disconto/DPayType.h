//
//  DPayType.h
//  Disconto
//
//  Created by user on 30.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPaymentModel.h"

@interface DPayType : NSObject

@property NSInteger payMin;
@property NSInteger payMax;
@property NSString *moneyType;
@property float commission;
@property BOOL payEnabled;
@property NSInteger payType;
@property NSMutableArray<DPaymentModel *> *payments;
@property NSString *title;
@property NSString *iconUrl;
@property NSString *iconString;

+ (void)getPayWithCallBack:(void (^)(NSArray<DPayType *> *resault,float pending,float balance))callBack;
- (NSString *)getActivePayWithIndexPath:(NSIndexPath *)indexPath;
@end
