//
//  DParentShopsViewController.m
//  Disconto
//
//  Created by user on 30.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DParentShopsViewController.h"
#import "DSendToSupportController.h"
#import "DProductsVM.h"

@interface DParentShopsViewController ()<SWRevealViewControllerDelegate>

//@property CLLocationManager *locationManager;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property SWRevealViewController *revealVC;
@property UITapGestureRecognizer *singleFingerTap;
@end

@implementation DParentShopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [StyleChangerClass changeBorderToButton:self.goToPhotoButton];
    [self initMapTaget];
    [self customSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.tabBarController.tabBar.barTintColor =  SYSTEM_NAV;
    self.navigationController.navigationBar.barTintColor = SYSTEM_NAV;
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    
    [self addChildViewController:vc];
    [vc.view setFrame:self.chaildView.bounds];
    [self.chaildView addSubview:vc.view];
    [StyleChangerClass changeButton:self.goToPhotoButton andController:self andTitle:titleGetPhotoChak];
    self.navigationController.navigationBar.translucent = NO;
    
   //\\\\\ self.title = titleShops;
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
    
    [self.view endEditing:YES];
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

- (IBAction)navigation:(id)sender {
    
//    DMapViewController *vc = [DMapViewController showMapViewControllerWithTarget:self.locationManager.location.coordinate];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToPhoto:(id)sender {
    
    [StyleChangerClass goToPhoto:self];
}


- (void)exitDisconto{
    
    [DSuperViewController logOut];
}

- (void)showProfile{
    
    MVVMSettingsViewController *vc = [MVVMSettingsViewController showSettingsWithModelView:[DSettingsViewModel new]];

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSetting{
    
    MVVMSettingsViewController *vc = [MVVMSettingsViewController showSettingsWithModelView:[DSettingsViewModel new]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)showInfo{
    
   // SHOW_MESSAGE(@"Версия", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]);
    [self showAlertWithTitle:@"Версия" message:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

- (void)showSendSupport{
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)showDiscontsWithController:(UIViewController *)controller andShopID:(NSString *)shopID{
//
//    DShopModel *store= [DShopModel new];
//    store.shopID = [shopID integerValue];
//
//    [self.navigationController pushViewController:[MVVMDProductsViewController showProductsWithViewModel:[DProductsVM showProductsOfShop:store]] animated:NO];
//
//}

- (void)initMapTaget{

    
//    self.locationManager = [CLLocationManager new];
//    _locationManager.delegate = self;
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    
//    [_locationManager startUpdatingLocation];
}

@end
