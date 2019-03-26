//
//  DSelectiorViewController.m
//  Disconto
//
//  Created by user on 29.06.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSelectiorViewController.h"
#import <Photos/Photos.h>


@interface DSelectiorViewController ()

@property NSMutableArray<DProductModel *> *productsArray;
@property DSelectorModel *selectorModel;
@end

@implementation DSelectiorViewController

+ (instancetype)showSelrctorViewControllerWithProductsArray:(NSArray <DProductModel *> *)products{
    
    return [[DSelectiorViewController alloc] initWithNibName:NSStringFromClass([DSelectiorViewController class]) bundle:nil andProducts:products];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProducts:(NSArray <DProductModel *> *)products
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        if (!isiPhone5 && isiPhone) {
            
            PHFetchOptions *allPhotosOptions = [PHFetchOptions new];
            allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
            
            PHFetchResult *allPhotosResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
            [allPhotosResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
                NSLog(@"asset %@", asset);
            }];
        }
        self.productsArray = @[].mutableCopy;
        self.productsArray = products.mutableCopy;
        self.selectorModel = [DSelectorModel new];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeButton];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = buyDiscontoTitle;
    [self.allPointsLabel setText:[NSString stringWithFormat:@"%@ %@",@(self.selectorModel.selectorCount),kRub]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

#pragma mark - TableView params

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 90.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.productsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DSelectProductCell *cell = [self.productsArray[indexPath.row] getCelllWithProduct:self.productsArray[indexPath.row] tableView:tableView indexPath:indexPath];
    cell.delegate = self;
    [cell.selectedLabel setFont:[UIFont boldSystemFontOfSize:16]];
    cell.unlocedCountLabel.layer.cornerRadius = cell.unlocedCountLabel.bounds.size.width*0.5;
    cell.unlocedCountLabel.layer.borderColor = SYSTEM_COLOR.CGColor;
    cell.unlocedCountLabel.layer.borderWidth = 1;
    [cell.statusImage setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

#pragma mark - DSelectorDelegate

- (void)selectPlusInCell:(id)cell andProduct:(id)product{
    
    
    DProductModel *activeProduct = product;
    if (activeProduct.unlocedCount > 0) {
        activeProduct.sectedCount += 1;
        activeProduct.unlocedCount -= 1;
        
        self.selectorModel.selectorCount = 0;
        for (DProductModel *obj in self.productsArray) {
           // self.selectorModel.selectorCount += (obj.sectedCount * obj.productPoint);
        }
        [self changeButton];
    }
    
    [self.tableView reloadData];
    [self.allPointsLabel setText:[NSString stringWithFormat:@"%@ %@",@(self.selectorModel.selectorCount),kRub]];
    
}

- (void)selectMinusInCell:(id)cell andProduct:(id)product{
    
    DProductModel *activeProduct = product;
    if (0 < activeProduct.sectedCount) {
        
        activeProduct.unlocedCount += 1;
        activeProduct.sectedCount -= 1;

        self.selectorModel.selectorCount = 0;
        for (DProductModel *obj in self.productsArray) {
          //  self.selectorModel.selectorCount += (obj.sectedCount * obj.productPoint);
        }
        [self changeButton];
    }

    [self.tableView reloadData];
    [self.allPointsLabel setText:[NSString stringWithFormat:@"%@ %@",@(self.selectorModel.selectorCount),kRub]];
}

- (void)changeButton{
    
    for (DProductModel *item in self.productsArray) {
        
        if (item.sectedCount > 0) {
            
            [StyleChangerClass changeButton:self.actionButton andController:self andTitle:@"Сделать фото чека"];
            self.actionButton.enabled = YES;
            self.actionButton.backgroundColor = SYSTEM_COLOR;
            break;
        }else{
            
            self.actionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            self.actionButton.backgroundColor = [UIColor lightGrayColor];
            self.actionButton.layer.cornerRadius = 4;
            self.actionButton.enabled = NO;
            [self.actionButton setTitle:selectDiscontText forState:UIControlStateNormal];
            for (UIImageView *imgView in self.actionButton.subviews) {
                
                if ([imgView isKindOfClass:[UIImageView class]]) {
                    
                    imgView.image = nil;
                }
            }
        }
        
    }
}

- (IBAction)goToPhoto:(id)sender {
    
    [self.navigationController pushViewController: [DScannerViewController showScannerViewController] animated:NO];
    
//    [QRScannerViewController loadScannerViewController:self.navigationController];
//    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//
//            if(granted) { // Access has been granted ..do something
//
//                NSMutableArray *arr = @[].mutableCopy;
//                for (DProductModel *obj in self.productsArray) {
//                    if (obj.sectedCount > 0) {
//                        [arr addObject:obj];
//                    }
//                }
//                DCacameraViewController *vc = [DCacameraViewController showCameraControllerWithProducts:arr andStoreID:self.shop.shopID];
//                vc.storeName = self.shop.shopName;
//
//                vc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:vc animated:YES];
//            } else
//            {
//
//                [[[UIAlertView alloc] initWithTitle:@"Дисконто" message:@"Пожалуйста, разрешите использование камеры в настройках для возможности фотографирования чеков" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"OK", nil] show];
//
//
//            }
//
//        });
//    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex > 0) {
        [DSuperViewController openSettings];
    }
    
}
@end
