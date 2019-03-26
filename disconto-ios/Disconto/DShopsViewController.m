//
//  DShopsViewController.m
//  Disconto
//
//  Created by user on 30.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DShopsViewController.h"
#import "MVVMDProductsViewController.h"
#import "DProductsVM.h"

@interface DShopsViewController ()

@property NSArray<DShopPreview *> *shopsArray;
@property DProductModel *product;

@end

@implementation DShopsViewController

+ (instancetype)showShopsWithProduct:(DProductModel *)product{

    return [[DShopsViewController alloc] initWithNibName:NSStringFromClass([DShopsViewController class]) bundle:nil andProduct:product];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProduct:(DProductModel *)product
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.product = product;
        self.shopsArray = @[];
        [DShopPreview shopsWithProduct:product withCallBack:^(NSArray *array) {
        
            if (array.count > 0) {
                self.shopsArray = array;
                [self.tableView reloadData];
            }else{
            
                //SHOW_MESSAGE(emptyDiscontoUnableText, nil)
                [self showAlertWithTitle:nil message:emptyDiscontoUnableText];
                [self.navigationController popViewControllerAnimated:NO];
            }

        }];
    }
    return self;
}

+ (instancetype)getAllShopsWithPrice:(BOOL)showPrice{

    DShopsViewController *vc = [[DShopsViewController alloc] initWithNibName:NSStringFromClass([DShopsViewController class]) bundle:nil];
    vc.showPrice = showPrice;
    return vc;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        
         self.shopsArray = @[];
        [DShopPreview getAllShopsWithCallBack:^(NSArray *array) {
            
           self.shopsArray = array;
            [self.tableView reloadData];
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    super.navigationItem.title = titleShops;
}

#pragma mark - UITableViewDelegate AND DataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.shopsArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DShopCellTableViewCell *cell = [DShopCellTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DShopCellTableViewCell class])];
    DShopPreview *obj = self.shopsArray[indexPath.row];
    [cell.shopImageView sd_setImageWithURL:obj.shopIcon
                          placeholderImage:nil
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     // [cell.progress setAlpha:0];
                                 }];
    [cell.shopNameLabel setText:self.shopsArray[indexPath.row].shopName];
    [cell.allDiscontLabel setText:[NSString stringWithFormat:@"%@%@",@(obj.allShopCount),kDisconto]];
    [cell.discontNewLabel setText:[NSString stringWithFormat:@"%@%@",@(obj.shopNewCount),kNew]];
    if (self.showPrice) {
        
        [cell.pointLabel setText:[NSString stringWithFormat:@"%@%@",@(obj.shopPoints),kRub]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (!self.isStepPhoto) {
        DShopModel *shop = [DShopModel new];
        shop.shopID = self.shopsArray[indexPath.row].shopID;
        shop.shopName = self.shopsArray[indexPath.row].shopName;
        [self.navigationController pushViewController:[MVVMDProductsViewController showProductsWithViewModel:[DProductsVM showProductsOfShop:shop]] animated:YES];

    }else{
    
        DShopModel *shop = [DShopModel new];
        shop.shopID = self.shopsArray[indexPath.row].shopID;
        shop.shopImageURL = self.shopsArray[indexPath.row].shopIcon;
        shop.shopName = self.shopsArray[indexPath.row].shopName;
        
        [self.product getUnlocedProductsWithShop:shop callBack:^(NSArray<DProductModel *> *array) {
            DSelectiorViewController *vc = [DSelectiorViewController showSelrctorViewControllerWithProductsArray:array];
            vc.shop = self.shopsArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
}

@end
