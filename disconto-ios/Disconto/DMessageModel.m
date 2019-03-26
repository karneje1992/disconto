//
//  DMessageModel.m
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DMessageModel.h"

@implementation DMessageModel

+ (void)getMessagesFromServerWithCallBack:(void (^)(NSArray *resault, NSInteger unreaded))callBack{
    
   
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",apiMessages] withCallBack:^(BOOL success, NSDictionary *resault) {
//        dispatch_async(dispatch_get_main_queue(), ^(void){

            if (success) {
                [DUserModel updateProfileWithCallBack:^(DUserModel *user) {
                    
                    if (resault) {
                        NSInteger counter = 0;
                        NSMutableArray *array = @[].mutableCopy;
                        for (NSDictionary *list in resault[kServerData][@"messages"]) {
                            
                            DMessageModel *object = [DMessageModel new];
                            object.message = [NSString stringWithFormat:@"%@, %@",user.userFirsName,list[titleMessage]];
                            object.uuidMessage = list[kID];
                            object.day = list[@"send_at"];
                            if ([object.message rangeOfString:@"#instruction"].location != NSNotFound) {
                                
                                object.message = [object.message stringByReplacingCharactersInRange:[object.message rangeOfString:@"#instruction"] withString:@""];
                                object.isTutorial = YES;
                            }
                            if ([list[@"read_at"] isKindOfClass:[NSString class]]) {
                                object.readit = YES;
                            }
                            
                            [array addObject:object];
                        }
                        counter = [resault[kServerData][@"unreaded"] integerValue];
                        callBack(array, counter);
                    }
                }];


            }
            
//        });
    }];
}

+ (void)readedMessage:(DMessageModel *)message withCallBack:(void (^)(BOOL succses))callBack{
    
    if (!message.readit) {
        callBack(message.readit);
    }else{
        
        [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"messages":message.uuidMessage} andAPICall:[NSString stringWithFormat:@"%@/",apiMessagesRead] withCallBack:^(BOOL success, NSDictionary *resault) {
            
            if (success) {
                
                callBack(success);
            }else{
                
                callBack(success);
            }
        }];
    
    }
}

@end
