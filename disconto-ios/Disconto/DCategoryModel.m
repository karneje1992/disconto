//
//  DCategoryModel.m
//  Disconto
//
//  Created by user on 16.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DCategoryModel.h"

@implementation DCategoryModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.categoryIcon = [NSURL URLWithString:dictionary[@"img_url"]];
        self.allCount = [dictionary[@"all_products"] integerValue];
        self.newCount = [dictionary[@"new_products"] integerValue];
        self.categoryName = dictionary[@"name"];
        self.categoryID = [NSString stringWithFormat:@"%@",dictionary[kID]] ? [NSString stringWithFormat:@"%@",dictionary[kID]] : @"top";
        
        if (dictionary[@"all_promos"]) {
            self.isPromos = YES;
            self.allCount = [dictionary[@"all_promos"] integerValue];
            self.newCount = [dictionary[@"new_promos"] integerValue];
        }
    }
    return self;
}

+ (void)getAllCategoryWithCallBack:(void (^)(BOOL success, NSArray *resault))callBack{
    
    __block NSMutableArray *array = @[].mutableCopy;
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",apiCategory] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
        
            if (success) {
                DCategoryModel *first = [DCategoryModel new];
                first.categoryID = @"top";
                first.categoryName = @"Все дисконты";
                first.newCount = -1;
                first.allCount = -1;
                [array addObject:first];
                for (NSDictionary *list in resault[kServerData]) {
                    
                    [array addObject:[[DCategoryModel alloc] initWithDictionary:list]];
                }
                callBack(array.count,array);
            }else{
                
                callBack(array.count,array);
            }
        });
    }];
}
@end
