//
//  DLoginModel.h
//  Disconto
//
//  Created by user on 12.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LoginScreanType) {
    login = 0,
    forgot
};

@interface DLoginModel : NSObject

@property NSString *loginValue;
@property NSString *passwordValue;
@property NSInteger loginType;
@property NSArray<DTextFildInputCell *> *cellsArray;

//- (void)setupCellsArrayWithScreenType:(NSInteger)screenType andController:(DLoginViewController *)controller andTableView:(UITableView *)tableView;
+ (void)loginWithLoginModel:(DLoginModel *)loginModel;
+ (void)loginInSocialWithDictionary:(NSDictionary *)dictionary callBack:(void (^)(BOOL logined))callBack;
+ (void)forgotWithLoginModel:(DLoginModel *)loginModel callBack:(void (^)(BOOL logined))callBack;
+ (NSString *)urlencode:(NSString *)input;

@end
