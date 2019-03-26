//
//  MainHistoricalViewController.m
//  Disconto
//
//  Created by Rostyslav Didenko on 2/10/19.
//  Copyright © 2019 Disconto. All rights reserved.
//

#import "MainHistoricalViewController.h"
#import "HistoricalViewController.h"

@interface MainHistoricalViewController ()<SWRevealViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;

@property UITapGestureRecognizer *singleFingerTap;
@property SWRevealViewController *revealVC;
@end

@implementation MainHistoricalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HistoricalViewController *vc = [HistoricalViewController showHistoricalViewControllerWithControlType: 0];
    [self addChildViewController: vc];
    [vc.view setFrame: self.contentView.bounds];
    [self.contentView addSubview: vc.view];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = SYSTEM_NAV;
    
    [self customSetup];
    // Do any additional setup after loading the view.
}

- (void)customSetup {
    _revealVC = self.revealViewController;
    _revealVC.delegate = self;
    _revealVC.rearViewRevealWidth = self.view.bounds.size.width*0.9;
    if ( _revealVC )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    
}

- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position{
    
    if (!_singleFingerTap) {
        _singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        _singleFingerTap.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:_singleFingerTap];
    }else{
        
        [self.view removeGestureRecognizer:_singleFingerTap];
        _singleFingerTap = nil;
    }
    
}
@end
