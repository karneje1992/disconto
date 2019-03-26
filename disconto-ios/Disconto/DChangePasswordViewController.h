//
//  DChangePasswordViewController.h
//  Disconto
//
//  Created by user on 26.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DChangePasswordViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *oldPassTextField;
@property (strong, nonatomic) IBOutlet UITextField *changedPassTextField;
@property (strong, nonatomic) IBOutlet UIView *popUpView;
@property (strong, nonatomic) IBOutlet UITextField *confermTextField;
@end
