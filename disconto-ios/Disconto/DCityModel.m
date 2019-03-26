//
//  DCityModel.m
//  Disconto
//
//  Created by user on 13.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DCityModel.h"

@implementation DCityModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.cityID = [NSString stringWithFormat:@"%@",dictionary[kID]];
        self.cityTitle = [NSString stringWithFormat:@"%@",dictionary[@"title"]];
    }
    return self;
}

+ (void)getCitesArraWithServerWithCallBack:(void (^)(NSArray *resault))callBack{

    __block NSMutableArray *array = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:apiCitys withCallBack:^(BOOL success, NSDictionary *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (success) {
                
                for (NSDictionary *list in resault[kServerData]) {
                    
                    [array addObject:[[DCityModel alloc] initWithDictionary:list]];
                }
                
                callBack(array);
            }
        });
    }];
}

@end
