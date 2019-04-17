//
//  MVVMDProductsViewController.m
//  Disconto
//
//  Created by Rostislav on 1/16/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "MVVMDProductsViewController.h"
#import "DProductsVM.h"
#import "DBanerModel.h"

@interface MVVMDProductsViewController ()<SWRevealViewControllerDelegate, MXBannerViewDelegate>

@property DProductsVM *viewModel;

@property NSMutableArray<DBanerModel *> *bannersArray;
@property NSMutableArray *urlsStr;
@end


@implementation MVVMDProductsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andModelView:(id)modelView
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _viewModel = modelView;
        _bannersArray = @[].mutableCopy;
        _urlsStr = @[].mutableCopy;
        
    }
    return self;
}

+ (instancetype)showProductsWithViewModel:(id)viewModel{
    
    return [[MVVMDProductsViewController alloc] initWithNibName:NSStringFromClass([MVVMDProductsViewController class]) bundle:nil andModelView:viewModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BannerCollectionReusableView" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"BannerCollectionReusableView"];
        [DBanerModel getNewBanersWithCallBack:^(NSArray *resault) {
    
            self.bannersArray = resault.mutableCopy;
    
            if (resault.count) {
    
                [resault enumerateObjectsUsingBlock:^(DBanerModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
                    [_urlsStr addObject: obj.banerImageUrl.absoluteString];
    
                }];
    
                [self.collectionView reloadData];
            }
    
        }];

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [StyleChangerClass changeButton:self.actionButton andController:self andTitle:titleGetPhotoChak];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_viewModel updateController:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.viewModel.modelsArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
     [self.navigationController pushViewController:[DSingleProductController openSingleProduct:self.viewModel.modelsArray[indexPath.row]] animated:YES];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.viewModel.modelsArray[indexPath.row] getCellsWithCollectionView:collectionView indexPath:indexPath andProduct:self.viewModel.modelsArray[indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = collectionView.frame.size.width*0.48;
    
    return CGSizeMake(cellWidth, cellWidth*1.3);
}


- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10,5,10,5);  // top, left, bottom, right
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    BannerCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BannerCollectionReusableView" forIndexPath:indexPath];
    
    headerView.subviews.firstObject.frame = CGRectMake(0, 0, collectionView.bounds.size.width, collectionView.bounds.size.width * 0.5);

    return (BannerCollectionReusableView *)headerView ;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{

    if ([elementKind isEqualToString: UICollectionElementKindSectionHeader]) {

        BannerCollectionReusableView *headerView = (BannerCollectionReusableView *)view;


        MXBannerView *bannerView = [[MXBannerView alloc] initWithFrame:headerView.subviews.firstObject.bounds type: MXImageTypeNetwork images: self.urlsStr];
        
        [bannerView setDelegate: self];
        [bannerView setShowPageControl:NO];
        //[bannerView setAutoScrollTimeInterval: 20];
        [bannerView setInfiniteScrollEnabled: YES];
        bannerView.selectedDotColor = SYSTEM_COLOR;
        bannerView.backgroundColor = [UIColor clearColor];
        [bannerView setAutoScrollEnabled: YES];
        [headerView.subviews.firstObject addSubview: bannerView];

    }
}

- (void)bannerView:(MXBannerView * _Nonnull)bannerView didSelectItemAtIndex:(NSUInteger)index{

    NSString *url = self.bannersArray[index].url;
    NSString *producID = self.bannersArray[index].productID;
    DProductModel *product = [self productWithID: [producID integerValue]];
    if (url) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
    }
    
    if (product) {
        
        [self openProduct: product];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return _urlsStr.count > 0 ? CGSizeMake(collectionView.bounds.size.width,  collectionView.bounds.size.width/2) : CGSizeZero;
}

- (DProductModel *)productWithID:(NSInteger)productID {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.productID == %d", productID];
    DProductModel *product = [self.viewModel.modelsArray filteredArrayUsingPredicate: predicate].firstObject;
    return product;
}

- (void)openProduct:(DProductModel *)product {
    
    [self.navigationController pushViewController:[DSingleProductController openSingleProduct: product] animated:YES];
}

#pragma mark - ScrollDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        
        [self.viewModel getModelsWithSkip:self.viewModel.modelsArray.count];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

}

- (IBAction)goToPhoto:(id)sender {
    
    [StyleChangerClass goToPhoto:self];
}


@end
