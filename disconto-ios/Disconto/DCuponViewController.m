//
//  DCuponViewController.m
//  Disconto
//
//  Created by user on 27.08.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DCuponViewController.h"
#import "ForceCubeListViewModel.h"
#import "DOfferModel.h"
#import "DOfferViewController.h"
#import "DOfferViewModel.h"
//#import <CoreBluetooth/CoreBluetooth.h>


@interface DCuponViewController ()<SWRevealViewControllerDelegate>

@property CLLocationManager * locationManager;
//@property CBCentralManager *bluetoothManager;
@property ForceCuBe *forceCube;
@property NSMutableArray *modelsArray;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property SWRevealViewController *revealVC;
@property UITapGestureRecognizer *singleFingerTap;
@end

@implementation DCuponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customSetup];

    [self.navigationItem setTitle:cuponsTitle];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadSubController];
  //  [self loadSubController];
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

- (void)loadSubController{

    SHOW_PROGRESS;
    [DOfferModel getCouponsWithCallBack:^(NSArray<DOfferModel *> *models1) {
        self.modelsArray = @[].mutableCopy;
        [self.modelsArray addObjectsFromArray:models1];
       
        [DOfferModel getForceCubeModelsWithCallBack:^(NSArray<DOfferModel *> *models) {
            
            [self.modelsArray addObjectsFromArray:models];
//            [[[[DForceCubeSubClass activeForceCube] campaignManager] acceptedOffers] enumerateObjectsUsingBlock:^(id<FCBCampaignOffer>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                
//                [self.modelsArray addObject:[[DOfferModel alloc] initWithOffer:obj]];
//                
//            }];
            
            if (self.modelsArray) {
                
                DOfferViewController *vc = [DOfferViewController showOffersWithViewModel:[DOfferViewModel showOffers:self.modelsArray]];
                [vc setParentTitle:self.navigationItem.title];
                [self addChildViewController:vc];
                vc.view.frame = self.view.bounds;
                [self.view addSubview:vc.view];
                HIDE_PROGRESS;
            }
        }];
        
    }];
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
    
   // SHOW_MESSAGE(@"Версия", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]);
    [self showAlertWithTitle:@"Версия" message:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

- (void)showSendSupport{
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region{

}

@end
