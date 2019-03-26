//
//  StyleChangerClass.h
//  Disconto
//
//  Created by user on 11.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StyleChangerClass : NSObject

+ (void)changeBorderToButton:(UIButton *)button;
+ (void)changeColorInPresentController:(UIViewController *)presentController;
+ (void)addRightButtonToNavifationBarFromController:(UIViewController *)controller andTitleWithButton:(NSString *)titleButton;
+ (void)addMaskToPhoneTextField:(UITextField *)phoneTextField andRange:(NSRange)range;
+ (void)changeButton:(UIButton *)button andController:(DSuperViewController *)controller andTitle:(NSString *)title;
+ (void)goToPhoto:(DSuperViewController *)controller;
@end
