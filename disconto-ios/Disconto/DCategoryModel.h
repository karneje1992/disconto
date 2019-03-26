//
//  DCategoryModel.h
//  Disconto
//
//  Created by user on 16.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCategoryModel : NSObject

@property NSString *categoryID;
@property NSString *categoryName;
@property NSURL *categoryIcon;
@property NSInteger allCount;
@property NSInteger newCount;
@property BOOL isPromos;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (void)getAllCategoryWithCallBack:(void (^)(BOOL success, NSArray *resault))callBack;
@end
