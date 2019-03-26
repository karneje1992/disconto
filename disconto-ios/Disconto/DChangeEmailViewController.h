//
//  DChangeEmailViewController.h
//  Disconto
//
//  Created by user on 27.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DChangeEmailViewControllerDelegate <NSObject>

- (void)controller:(id)controller isChanged:(BOOL)isChanged;

@end

@interface DChangeEmailViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *popUpView;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property  id <DChangeEmailViewControllerDelegate> delegete;
+ (instancetype)changeEmail:(NSString *)email;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andEmail:(NSString *)email;
@end
