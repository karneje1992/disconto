//
//  DMessageModel.h
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMessageModel : NSObject

@property NSString *uuidMessage;
@property NSString *message;
@property NSString *day;
@property NSString *time;
@property BOOL readit;
@property BOOL isTutorial;

+ (void)getMessagesFromServerWithCallBack:(void (^)(NSArray *resault, NSInteger unreaded))callBack;
+ (void)readedMessage:(DMessageModel *)message withCallBack:(void (^)(BOOL succses))callBack;
@end
