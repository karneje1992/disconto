//
//  DCodeViewController.h
//  Disconto
//
//  Created by Ross on 29.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCodeViewControllerDelegate <NSObject>

- (void)changePhoneFromController:(UIViewController *)controller;
- (void)exitPhoneFromController:(UIViewController *)controller;
@end
@interface DCodeViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property id <DCodeViewControllerDelegate> delegate;
@property NSString *phone;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@end
