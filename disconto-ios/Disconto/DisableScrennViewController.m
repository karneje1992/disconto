//
//  DisableScrennViewController.m
//  Disconto
//
//  Created by Rostislav on 1/25/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DisableScrennViewController.h"

@interface DisableScrennViewController ()

@property SWRevealViewController *revealVC;
@end

@implementation DisableScrennViewController

+ (instancetype)showDisableSceenRevealViewController:(SWRevealViewController *)revealViewController{

    return [[DisableScrennViewController alloc] initWithNibName:NSStringFromClass([DisableScrennViewController class]) bundle:nil revealViewController:revealViewController];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil revealViewController:(SWRevealViewController *)controller
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _revealVC = controller;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {

    [_revealVC rightRevealToggle:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
