//
//  DStartViewController.m
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "DStartViewController.h"
#import "DStartViewModel.h"
#import "DEntranceViewController.h"
#import "DRegistrationViewModel.h"
#import "DLoginViewModel.h"

@interface DStartViewController ()

@property DStartViewModel *viewModel;
@end

@implementation DStartViewController

+ (instancetype)showStartScreenWithViewModel:(id)viewModel{

    return [[DStartViewController alloc] initWithNibName:NSStringFromClass([DStartViewController class]) bundle:nil viewModel:viewModel];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setViewModel:viewModel];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel setupUIWithCotroller:self];
 //   [self blure];
//    [self animation];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)registrationAction:(id)sender {
    
    [self.navigationController pushViewController:[[DRViewController alloc] initWithNibName:NSStringFromClass([DRViewController class]) bundle:nil] animated:YES];

}

- (IBAction)loginAction:(id)sender {
    
        [self.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:[[DLoginViewModel alloc] initWhithParametrs:@{}] andShowSocButtons:YES] animated:YES];
}
- (IBAction)support:(id)sender {
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
