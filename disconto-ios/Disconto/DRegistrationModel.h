//
//  DRegistrationModel.h
//  Disconto
//
//  Created by user on 12.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RegistrationScreanType) {
    username = 0,
    city,
    email,
    password
};

@interface DRegistrationModel : NSObject

@property NSString *firstName;
@property NSString *lastName;
@property NSString *cityID;
@property NSString *cityName;
@property NSString *email;
@property NSString *firstPassword;
@property NSString *lastPassword;
@property NSArray<DTextFildInputCell *> *cellsArray;
@property NSInteger screenType;
@property NSString *socID;
@property NSString *socType;
@property BOOL registrationComplite;

//- (void)setupCellsArrayWithScreenType:(NSInteger)screenType andController:(DLoginViewController *)controller andTableView:(UITableView *)tableView ;
+ (void)registrationFromServerWithModel:(DRegistrationModel *)registrationModel;
+ (void)registrationGETFromServerWithModel:(DRegistrationModel *)registrationModel;

@end
