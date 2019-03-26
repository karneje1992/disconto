//
//  StyleChangerClass.m
//  Disconto
//
//  Created by user on 11.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "StyleChangerClass.h"

@implementation StyleChangerClass

+ (void)changeBorderToButton:(UIButton *)button{
    
    button.layer.cornerRadius = 4.0f;
}

+ (void)changeColorInPresentController:(UIViewController *)presentController{
    
    presentController.view.backgroundColor = SYSTEM_COLOR;
    [presentController.navigationController.navigationBar setBarTintColor:SYSTEM_NAV];
    presentController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:presentController action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    presentController.navigationController.navigationBar.topItem.leftBarButtonItem = backButtonItem;
    UIImage *img = [UIImage imageNamed:@"ico"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgView setImage:img];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    presentController.navigationItem.titleView = imgView;
}

+ (void)addRightButtonToNavifationBarFromController:(UIViewController *)controller andTitleWithButton:(NSString *)titleButton{
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:titleButton style:UIBarButtonItemStylePlain target:controller action:@selector(doneAction)];
    controller.navigationItem.rightBarButtonItem = rightButton;
    [controller.navigationItem.rightBarButtonItem setEnabled:NO];
    // rightButton.enabled = NO;
}

+ (void)addMaskToPhoneTextField:(UITextField *)phoneTextField andRange:(NSRange)range{
    
    if (!phoneTextField.leftView ) {
        
        phoneTextField.text = @"";
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, phoneTextField.frame.size.height*0.5, phoneTextField.frame.size.height)];
        UILabel *maskLabel = [[UILabel alloc] init];
        maskLabel.text = @"(+7)";
        maskLabel.textAlignment = NSTextAlignmentCenter;
        [maskLabel setFrame:maskView.frame];
        maskLabel.font = phoneTextField.font;
        [maskView addSubview:maskLabel];
        phoneTextField.leftView = maskView;
        phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        
    }else if(phoneTextField.text.length == 0){
        
        phoneTextField.leftView = nil;
    }
}

+ (void)changeButton:(UIButton *)button andController:(DSuperViewController *)controller andTitle:(NSString *)title{
    
    button.layer.cornerRadius = 4;
    button.enabled = YES;
    button.alpha = 1;
    button.backgroundColor = SYSTEM_COLOR;
    
    UIImageView *imageFromButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera"]];
    imageFromButton.frame = CGRectMake(button.bounds.size.width * 0.5 + (button.bounds.size.height-10)*2.7, 5, button.bounds.size.height-10, button.bounds.size.height-10);
    [button setTitle:title forState:UIControlStateNormal];
    [button addSubview:imageFromButton];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
    
}

+ (void)goToPhoto:(DSuperViewController *)controller{

    
        [controller.navigationController pushViewController:[DScannerViewController showScannerViewController] animated:NO];

}
@end
