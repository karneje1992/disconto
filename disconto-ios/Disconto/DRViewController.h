//
//  DRViewController.h
//  Disconto
//
//  Created by Rostislav on 02.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface DRViewController : DSuperViewController<VKSdkDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *animatedView;
@property (strong, nonatomic) IBOutlet UIButton *vkbutton;
@property (strong, nonatomic) IBOutlet UIButton *fbButton;
@property (strong, nonatomic) IBOutlet UIButton *okButton;

@property (strong, nonatomic) IBOutlet UIView *blureView;
@property (strong, nonatomic) IBOutlet UILabel *otherLabel;
@end
