//
//  DHistoryModel.m
//  Disconto
//
//  Created by Ross on 31.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DHistoryModel.h"

@implementation DHistoryModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.products = @[].mutableCopy;
        self.historyID = [dictionary[@"id"] integerValue];
        self.actionType = [dictionary[@"action_type"] integerValue];
        self.dateHistory = dictionary[@"date"];
        self.title = dictionary[@"title"];
        self.message = dictionary[titleMessage];
        
        if (dictionary[@"checktab"] == ( NSString *) [ NSNull null ]) {
            self.checktab = @"";
        }else
        self.checktab = dictionary[@"checktab"] ? dictionary[@"checktab"] : dictionary[@"img_url"];
        self.imgURL = [NSURL URLWithString:dictionary[@"img_url"]];
        self.point = dictionary[@"points"];
        
        for (NSDictionary *list in dictionary[@"products"]) {
            
            [self.products addObject:[[DProductModel alloc] initWithShortResponse:list]];
        }
        self.bodyText = [NSString stringWithFormat:@"%@\nДата: %@", self.title, self.dateHistory,_point];

    }
    return self;
}

- (instancetype)initProgressWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.actionType = [dictionary[@"action_type"] integerValue];
        self.dateHistory = dictionary[@"date"];
        self.message = dictionary[@"title"];
        self.checktab = dictionary[@"img_url"];
    }
    return self;
}

@end
