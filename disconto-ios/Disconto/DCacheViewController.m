//
//  DCacheViewController.m
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DCacheViewController.h"


@interface DCacheViewController ()<SWRevealViewControllerDelegate,DMoneyViewControllerDelegate>

@property NSInteger screen;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property SWRevealViewController *revealVC;
@property UITapGestureRecognizer *singleFingerTap;

@end

@implementation DCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self customSetup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    //[self money:self];
    self.tabBarController.tabBar.barTintColor =  SYSTEM_NAV;
    self.navigationController.navigationBar.barTintColor = SYSTEM_NAV;
    self.title = @"Кошелек";
    switch (_screen) {
        case inProgress:
            [self inProgress:self];
            break;
        case history:
            [self history:self];
            break;
        default:
            [self money:self];
            break;
    }
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

- (IBAction)money:(id)sender {
    
    _screen = moneyOut;
    [self activeButton:self.moneyButton];
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        DMoneyViewController *vc = [DMoneyViewController showMoneyControllerWithUser:resault];
        vc.delegate = self;
        [self addChildViewController:vc];
        vc.view.frame = self.contentView.bounds;
        [self.contentView addSubview:vc.view];
    }];
}

- (IBAction)inProgress:(id)sender {
    
    _screen = inProgress;
    [self activeButton:self.inProgressButton];
    DInProgressTableViewController *vc = [[DInProgressTableViewController alloc] initWithNibName:NSStringFromClass([DInProgressTableViewController class]) bundle:nil];
    [self addChildViewController:vc];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
}

- (IBAction)history:(id)sender {
    
    _screen = history;
    [self activeButton:self.historyButton];
    DHistoryTableViewController *vc = [[DHistoryTableViewController alloc] initWithNibName:NSStringFromClass([DHistoryTableViewController class]) bundle:nil];
    [self addChildViewController:vc];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
}

- (void)activeButton:(UIButton *)button{


    [button setTitleColor:[UIColor colorWithRed:255/255.0 green:90/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    button.backgroundColor = [UIColor whiteColor];
    
    if (button == self.moneyButton) {
        
        [self resizeHeader:65];
        [self disableButton:self.inProgressButton];
        [self disableButton:self.historyButton];
    }

    if (button == self.inProgressButton) {
        [self resizeHeader:0];
        [self disableButton:self.moneyButton];
        [self disableButton:self.historyButton];
    }
    
    if (button == self.historyButton) {
        [self resizeHeader:0];
        [self disableButton:self.inProgressButton];
        [self disableButton:self.moneyButton];
    }
}

- (void)resizeHeader:(float)hieght{

    [self.headerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj setAlpha:hieght];
    }];
    
    [self.headerLayout setConstant:hieght];
}

- (void)disableButton:(UIButton *)button{

    button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
    
    [self showAlertWithTitle:@"Версия" message:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
   // SHOW_MESSAGE(@"Версия", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]);
}

- (void)showSendSupport{
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)presentMoney:(float)balance pading:(float)pading{

    self.balanceLabel.text = [NSString stringWithFormat:@"%@",@(balance)];
    self.padingLabel.text = [NSString stringWithFormat:@"%@",@(pading)];
}
@end
