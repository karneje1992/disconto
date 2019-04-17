//
//  MVVMCategoryViewController.m
//  Disconto
//
//  Created by Rostislav on 09.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "MVVMCategoryViewController.h"

#import "MVVMSettingsViewController.h"
#import "DSettingsViewModel.h"
#import "UIScrollView+APParallaxHeader.h"
#import "DSubTableViewController.h"
#import "DCategoryViewModel.h"
#import "SWRevealViewController.h"
#import "DBanerModel.h"
#import "MVVMDProductsViewController.h"

//static const float headerRatio = 0.4;

@interface MVVMCategoryViewController ()<SWRevealViewControllerDelegate, MVVMDProductsViewControllerDelegate>

@property NSArray<DBanerModel *> *bunnersArray;
@property NSMutableArray<DCategoryModel *> *cellsArray;
@property NSMutableArray *array;
@property NSArray *messages;
@property SWRevealViewController *revealVC;
@property UITapGestureRecognizer *singleFingerTap;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property NSMutableArray *modelsArray;


@end

@implementation MVVMCategoryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    self.bannerConstraint.constant = 0 - self.bannerView.bounds.size.height;
    _modelsArray = @[].mutableCopy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [StyleChangerClass changeButton:self.goToPhoto andController:self andTitle:titleGetPhotoChak];
    [DMessageModel getMessagesFromServerWithCallBack:^(NSArray *resault, NSInteger unreaded) {
        
        self.messages = resault;
        [self.messageButton setTitle:[NSString stringWithFormat:@"%@",@(unreaded)] forState:UIControlStateNormal];
        
    }];
    
    MVVMDProductsViewController *vc = [MVVMDProductsViewController showProductsWithViewModel:[DProductsVM showProductsOfCategory: 0]];
    [vc setDelegate: self];
    
    [self addChildViewController:vc];
    [vc.view setFrame:self.contentView.bounds];
    [self.contentView addSubview:vc.view];
}

- (void)loadNewBanner {
    
//    [DProductModel getNewAllProductsWithCollectionView:nil skip:0 category:0 andCallBack:^(NSArray *array) {
//        
//        _modelsArray = array.mutableCopy;
//        
//    }];
    
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
    
    [self loadNewBanner];

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

- (IBAction)showMessage:(id)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        DReadMessageViewController *vc = [[DReadMessageViewController alloc] initWithNibName:NSStringFromClass([DReadMessageViewController class]) bundle:nil andMessages:self.messages];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    });
    
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
    
   // SHOW_MESSAGE(@"Версия", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]);
    [self showAlertWithTitle:@"Версия" message:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

- (void)showSendSupport{
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goToPhoto:(id)sender {
    
    [StyleChangerClass goToPhoto:self];
}

#pragma mark - uialertDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            break;
            
        default:{
            
            DTutorialViewController *vc = [DTutorialViewController showTutorialWithImgArray:[DSuperViewController getTutorial] andShowButton:NO];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
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

- (void)bannerView:(MXBannerView * _Nonnull)bannerView didSelectItemAtIndex:(NSUInteger)index{
    
    [self.modelsArray enumerateObjectsUsingBlock:^(DProductModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.productID == [self.bunnersArray[index].productID intValue]){
            
            if (self.bunnersArray[index].url.length) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: self.bunnersArray[index].url]];
            }
            [self.navigationController pushViewController:[DSingleProductController openSingleProduct: obj] animated:YES];
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= self.bannerView.bounds.size.height) {
            
            self.bannerConstraint.constant = self.bannerConstraint.constant - scrollView.contentOffset.y + 2;
        } else if (scrollView.contentOffset.y <= 0 ){
            
            self.bannerConstraint.constant = self.bannerConstraint.constant + scrollView.contentOffset.y + 2;
        }else{
            
            self.bannerConstraint.constant = 0;
        }
    }];
    

}

@end
