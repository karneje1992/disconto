//
//  DHistoryModel.h
//  Disconto
//
//  Created by Ross on 31.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHistoryModel : NSObject

@property NSInteger actionType;
@property NSString *message;
@property NSString *dateHistory;
@property NSString *checktab;
@property NSURL *imgURL;
@property NSString *point;
@property NSMutableArray <DProductModel *> *products;
@property NSString *title;
@property NSInteger historyID;
@property NSString *bodyText;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initProgressWithDictionary:(NSDictionary *)dictionary;
@end
