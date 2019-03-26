//
//  DEntranceViewController.h
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"
#import "CCTextFieldEffects.h"
#import "TTTAttributedLabel.h"


@interface DEntranceViewController : DSuperViewController <UITableViewDelegate, UITableViewDataSource,TTTAttributedLabelDelegate>
@property (strong, nonatomic) IBOutlet UIButton *okButton;
@property (strong, nonatomic) IBOutlet UIButton *vkButton;
@property (strong, nonatomic) IBOutlet UIButton *fbButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *blureView;
@property (strong, nonatomic) IBOutlet UIView *animatedView;

@property (strong, nonatomic) IBOutlet UIView *socView;
@property (strong, nonatomic) IBOutlet UIButton *screenButton;
@property (strong, nonatomic) IBOutlet TTTAttributedLabel *screenLabel;
+ (instancetype)showEntranceViewControllerWithViewModel:(id)viewModel andShowSocButtons:(BOOL)showSocButtons;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel andShowSocButtons:(BOOL)showSocButtons;

@end
