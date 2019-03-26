//
//  DProductsViewController.m
//  Disconto
//
//  Created by user on 17.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DProductsViewController.h"
#import "MVVMDProductsViewController.h"
#import "DProductsVM.h"

@interface DProductsViewController ()

@property NSMutableArray<DProductModel *> *modelsArray;
@property NSInteger shopID;
@end

@implementation DProductsViewController

+ (instancetype)showProductsWithCategory:(DCategoryModel *)category{
    
    return [[DProductsViewController alloc] initWithNibName:NSStringFromClass([DProductsViewController class]) bundle:nil andCategory:category];
}

+ (instancetype)showProductsWithShopID:(NSInteger)shopID andTitle:(NSString *)title{
    
    return [[DProductsViewController alloc] initWithNibName:NSStringFromClass([DProductsViewController class]) bundle:nil andShopID:shopID andTitle:title];
}

+ (instancetype)showProductsWithProductsArray:(NSArray *)productsArray{
    
    return [[DProductsViewController alloc] initWithNibName:NSStringFromClass([DProductsViewController class]) bundle:nil andProducts:productsArray];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andShopID:(NSInteger)shopID andTitle:(NSString *)title
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.shopID = shopID;
        self.modelsArray = @[].mutableCopy;
        self.title = title;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andCategory:(DCategoryModel *)category
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.category = category;
        self.modelsArray = @[].mutableCopy;
        self.title = self.category.categoryName;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProducts:(NSArray *)products
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.modelsArray = products.mutableCopy;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [StyleChangerClass changeButton:self.photoButton andController:self andTitle:titleGetPhotoChak];
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"rightMenu"] style:UIBarButtonItemStylePlain target:self action:@selector(showRightMenu:)];
    
    self.navigationItem.rightBarButtonItem = flipButton;
    [self.photoButton setAlpha:!self.modelsArray.count];
    if (self.alertText) {
       // SHOW_MESSAGE(self.title, self.alertText);
            [self showAlertWithTitle:self.title message:self.alertText];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    

    if (self.shopID) {
        
        [self getShopProductWithSkip:self.modelsArray.count];
    }else{
        
        [self getCategoryProductWithSkip:self.modelsArray.count];
    }

    HIDE_PROGRESS;
    [self.collectionView reloadData];
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

- (void)showSendSupport{
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat cellWidth = collectionView.frame.size.width*0.45;
//    
//    return CGSizeMake(cellWidth, cellWidth*205/168);
//    // Adjust cell size for orientation
//}

- (void)getCategoryProductWithSkip:(NSInteger)skip{
    
    HIDE_PROGRESS;
    if (_category) {
        [DProductModel getNewAllProductsWithCollectionView:self.collectionView skip:skip category:self.category andCallBack:^(NSArray<DProductModel *> *array) {
            
            self.modelsArray = array.mutableCopy;
            [self.collectionView reloadData];
            
            //   self.navigationItem.title = self.category.categoryName;
        }];
    }else{
        [self.collectionView reloadData];
    }
    
}

- (void)getShopProductWithSkip:(NSInteger)skip{
    
    HIDE_PROGRESS;
    [DProductModel getAllProductsWithCollectionView:self.collectionView skip:skip shopID:self.shopID andCallBack:^(NSArray<DProductModel *> *array) {
        
        self.modelsArray = array.mutableCopy;
        [self.collectionView reloadData];
        [self.collectionView reloadData];
        
        //   self.navigationItem.title = self.category.categoryName;
    }];
}

//- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    
//    return UIEdgeInsetsMake(5,15,5,15);  // top, left, bottom, right
//}
#pragma mark - ScrollDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        
        if (self.category) {
            
            [self getCategoryProductWithSkip:self.modelsArray.count];
        }
        
        if (self.shopID) {
            
            [self getShopProductWithSkip:self.modelsArray.count];
        }
    }
}

- (IBAction)goToPhoto:(id)sender {
    
    [StyleChangerClass goToPhoto:self];
}

@end
