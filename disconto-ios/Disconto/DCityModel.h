//
//  DCityModel.h
//  Disconto
//
//  Created by user on 13.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCityModel : NSObject

@property NSString *cityID;
@property NSString *cityTitle;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (void)getCitesArraWithServerWithCallBack:(void (^)(NSArray *resault))callBack;
@end
