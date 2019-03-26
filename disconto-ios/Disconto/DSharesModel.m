//
//  D DSharesModel.m
//  Disconto
//
//  Created by user on 19.08.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSharesModel.h"

@implementation DSharesModel

- (instancetype)initWithDictioary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.instructionArray = @[].mutableCopy;
        self.sharesID = [dictionary[kID] integerValue];
        self.imgURL = [NSURL URLWithString:dictionary[@"img_url"]];
        [dictionary[@"instructions"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([NSData dataWithContentsOfURL:[NSURL URLWithString:obj]]) {
                [self.instructionArray addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:obj]]]];
            }
            
        }];
//        ![dictionary[@"instructions"] isKindOfClass:[NSArray class]] ? self.instructionArray = @[].mutableCopy : [dictionary[@"instructions"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            SHOW_PROGRESS;

//            HIDE_PROGRESS;
//        }];
        self.sharesName = dictionary[@"name"];
        self.rootURL = [NSURL URLWithString:dictionary[@"url"] != (id)[NSNull null] ? dictionary[@"url"] : @"https://disconto.me"];
        self.unloced = [dictionary[@"unlocked"] boolValue];
        self.type = dictionary[@"type"];
        self.gameID = dictionary[@"game_id"];
    }
        return self;
}

+ (void)getFullItemsForCollectionViewWithCallBack:(void (^)(NSArray <DSharesModel *> *modelsArray))callBack{
    
    __block NSMutableArray *items = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:apiGetPromos withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            NSArray *array = resault[kServerData];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    [items addObject:[[DSharesModel alloc] initWithDictioary:obj]];
                }else{
                    
                    callBack(@[]);
                    return;
                }
            }];
        }
        callBack(items);
    }];
}

+ (void)getFullItemsCuponsForCollectionViewWithUser:(DUserModel *)user withCallBack:(void (^)(NSArray <DSharesModel *> *modelsArray))callBack{
    
    __block NSMutableArray *items = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:@"/coupons" withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            NSArray *array = resault[kServerData];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    [items addObject:[[DSharesModel alloc] initWithDictioary:obj]];
                }else{
                    
                    callBack(@[]);
                    return;
                }
            }];
        }
        callBack(items);
    }];
}
@end
