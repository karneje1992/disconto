//
//  D DSharesController.m
//  Disconto
//
//  Created by user on 19.08.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSharesController.h"
#import "CollectionViewCell.h"
#import "SharesTableViewController.h"
#import "SharesViewModel.h"
#import "DOfferModel.h"
#import "DOfferViewController.h"
#import "ForceCubeListViewModel.h"
#import "ForceCubeListController.h"
#import "DOfferViewModel.h"

@interface DSharesController ()<SWRevealViewControllerDelegate>

@property NSArray <DSharesModel *> *modelsArray;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property SWRevealViewController *revealVC;
@property UITapGestureRecognizer *singleFingerTap;
@end

@implementation DSharesController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    SHOW_PROGRESS;
    self.tabBarController.tabBar.barTintColor =  SYSTEM_NAV;
    self.navigationController.navigationBar.barTintColor = SYSTEM_NAV;
    [self.navigationItem setTitle:@"Акции"];
        [DOfferModel getPromosWithCallBack:^(NSArray<DOfferModel *> *models) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //tell the main UI thread here
                DOfferViewController *vc = [DOfferViewController showOffersWithViewModel:[DOfferViewModel showOffers:models]];
                [vc setParentTitle:self.navigationItem.title];
                [self addChildViewController:vc];
                vc.view.frame = self.view.bounds;
                [self.view addSubview:vc.view];
            });
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  }

- (void)customSetup
{
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

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    NSLog(@"%@",[(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController visibleViewController].childViewControllers);
    [_revealVC rightRevealToggle:self];
    
}


#pragma mark state preservation / restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}


- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}


- (void)applicationFinishedRestoringState
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Call whatever function you need to visually restore
    [self customSetup];
}

- (IBAction)showRightMenu:(id)sender {
    
}

- (void)exitDisconto{
    
    [DSuperViewController logOut];
}

- (void)showProfile{
    
    DProfileViewController *vc = [[UIStoryboard storyboardWithName:@"DTabBarController" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DProfileViewController class])];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSetting{
    
    MVVMSettingsViewController *vc = [MVVMSettingsViewController showSettingsWithModelView:[DSettingsViewModel new]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)showInfo{
    
    //SHOW_MESSAGE(@"Версия", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]);
    [self showAlertWithTitle:@"Версия" message:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

- (void)showSendSupport{
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
