//
//  DCapchaViewController.h
//  Disconto
//
//  Created by Rostislav on 7/28/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCapchaPresenterProtocol.h"

@interface DCapchaViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *inputField;

@property id<DCapchaPresenterProtocol> presenter;
+ (DCapchaViewController *)showCapchaViewController;
@end
