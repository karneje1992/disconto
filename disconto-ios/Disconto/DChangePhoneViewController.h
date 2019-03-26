//
//  DChangePhoneViewController.h
//  Disconto
//
//  Created by user on 27.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DChangePhoneViewControllerDelegate <NSObject>

- (void)sended;

@end
@interface DChangePhoneViewController : UIViewController<UITextFieldDelegate>

@property id <DChangePhoneViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *popUpView;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
+ (instancetype)changePhone:(NSString *)phone;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPhone:(NSString *)phone;
@end
