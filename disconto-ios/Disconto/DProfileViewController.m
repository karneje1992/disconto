//
//  DProfileViewController.m
//  Disconto
//
//  Created by user on 23.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DProfileViewController.h"

//#import "CSStickyHeaderFlowLayout.h"
@interface DProfileViewController ()<SWRevealViewControllerDelegate>
@property NSArray *messages;
@property DUserModel *user;
@property NSMutableArray<DProductModel *> *modelsArray;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property SWRevealViewController *revealVC;
@property (weak, nonatomic) IBOutlet UIView *chaildView;
@property UITapGestureRecognizer *singleFingerTap;
@end

@implementation DProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [StyleChangerClass changeBorderToButton:self.photoButton];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.barTintColor =  SYSTEM_NAV;
    self.navigationController.navigationBar.barTintColor = SYSTEM_NAV;
    self.title = titleProfile;
    [self.view setBackgroundColor:SYSTEM_COLOR];

    self.modelsArray = @[].mutableCopy;
    self.view.backgroundColor = SYSTEM_COLOR;

        [self customSetup];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
        MVVMSettingsViewController *vc = [MVVMSettingsViewController showSettingsWithModelView:[DSettingsViewModel new]];
    
    [self addChildViewController:vc];
    [vc.view setFrame:self.chaildView.bounds];
    [self.chaildView addSubview:vc.view];

    self.navigationController.navigationBar.translucent = NO;
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

- (IBAction)showSMS:(id)sender {
    
    DReadMessageViewController *vc = [[DReadMessageViewController alloc] initWithNibName:NSStringFromClass([DReadMessageViewController class]) bundle:nil andMessages:self.messages];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)sendSMS:(id)sender {
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:@"DSendToSupportController" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)showSetting:(id)sender {
    
    DSettingViewController *vc = [[DSettingViewController alloc] initWithNibName:@"DSettingViewController" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToPhoto:(id)sender {
    
    [StyleChangerClass goToPhoto:self];
}
@end
