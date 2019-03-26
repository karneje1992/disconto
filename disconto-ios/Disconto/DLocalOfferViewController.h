//
//  DLocalOfferViewController.h
//  Disconto
//
//  Created by Rostislav on 10.08.17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLocalOfferPresenterProtocol.h"

@interface DLocalOfferViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UIImageView *textFieldBackgroundImageView;
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@property id <DLocalOfferPresenterProtocol> presenter;

+ (DLocalOfferViewController *)showDLocalOfferViewController;
@end
