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
@property UITapGestureRecognizer *singleFingerTap;
@end

@implementation DProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [StyleChangerClass changeBorderToButton:self.photoButton];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.barTintColor =  SYSTEM_NAV;
    self.navigationController.navigationBar.barTintColor = SYSTEM_NAV;
    SHOW_PROGRESS;
    self.title = titleProfile;
    [self.view setBackgroundColor:SYSTEM_COLOR];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [DMessageModel getMessagesFromServerWithCallBack:^(NSArray *resault, NSInteger unreaded) {
            
            self.messages = resault;
            [self.messageButton setTitle:[NSString stringWithFormat:@"%@",@(unreaded)] forState:UIControlStateNormal];
        }];
        
    });
    self.modelsArray = @[].mutableCopy;
    self.view.backgroundColor = SYSTEM_COLOR;
    CSStickyHeaderFlowLayout *layout = (id)self.collectionView;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.bounds.size.width, 57);
    }
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"HeaderCollectionReusableView"];

    [DProductModel getFavoriteProductsWithCallBack:^(NSArray<DProductModel *> *array) {
        self.modelsArray = array.mutableCopy;
        [self.collectionView reloadData];
        
        HIDE_PROGRESS;
        [StyleChangerClass changeButton:self.photoButton andController:self andTitle:titleGetPhotoChak];
    }];
        [self customSetup];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [DMessageModel getMessagesFromServerWithCallBack:^(NSArray *resault, NSInteger unreaded) {
        
        [self.messageButton setTitle:[NSString stringWithFormat:@"%@",@(unreaded)] forState:UIControlStateNormal];
        HIDE_PROGRESS;
    }];
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        self.user = resault;
        [self.collectionView reloadData];
   //     [self.navigationItem.leftBarButtonItem setTitle:[NSString stringWithFormat:@"%@ %@",resault.userFirsName, resault.userLastName]];
        HIDE_PROGRESS;
    }];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

     HIDE_PROGRESS;
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

#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.modelsArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController pushViewController:[DSingleProductController openSingleProduct:self.modelsArray[indexPath.row]] animated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return [self.modelsArray[indexPath.row] getCellsWithCollectionView:collectionView indexPath:indexPath andProduct:self.modelsArray[indexPath.row]];
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
      return UIEdgeInsetsMake(10,5,10,5);  // top, left, bottom, right
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = collectionView.frame.size.width*0.48;
    
    return CGSizeMake(cellWidth, cellWidth*1.3);
    // Adjust cell size for orientation
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height*0.2);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderCollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView" forIndexPath:indexPath];
    
    if (self.user) {
        reusableview.backgroundColor = SYSTEM_COLOR;
        [reusableview.cityLabel setText:self.user.userCityName];
        [reusableview.balanceLabel setText:[NSString stringWithFormat:@"%@ руб. баланс",@(self.user.userPoints)]];
        [reusableview.nameLabel setText:[NSString stringWithFormat:@"%@ %@",self.user.userFirsName, self.user.userLastName]];
    }
    
    if (kind == UICollectionElementKindSectionHeader) {
        
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        
        
    }
    
    return reusableview;
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
