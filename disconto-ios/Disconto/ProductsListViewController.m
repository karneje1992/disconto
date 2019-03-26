//
//  ProductsListViewController.m
//  Disconto
//
//  Created by Rostyslav Didenko on 3/19/19.
//  Copyright © 2019 Disconto. All rights reserved.
//

#import "ProductsListViewController.h"
#import "ProductForOrderTableViewCell.h"

@interface ProductsListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray <DProductModel *> *products;
@property NSArray <DProductModel *> *serverProducts;
@end

@implementation ProductsListViewController

+ (instancetype)showOrderProducts:(NSArray<DProductModel *> *)products {
    
    return [[ProductsListViewController alloc] initWithNibName:@"ProductsListViewController" bundle: nil products: products];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil products:(NSArray<DProductModel *> *)products{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.serverProducts = @[];
        self.products = @[];
        self.products = products;
        [self loadItemsFromServer];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SYSTEM_NAV;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Private

- (void)loadItemsFromServer {
    
    [DProductModel getNewAllProductsWithCollectionView:nil skip:0 category:nil andCallBack:^(NSArray *array) {
        
        self.serverProducts = array;
        [self.tableView reloadData];
    }];
}

- (DProductModel *)getProductWhithID:(NSInteger)productID{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.productID == %d AND SELF.productID != 0",productID];
    NSArray<DProductModel *> *filter = [self.serverProducts filteredArrayUsingPredicate: predicate];
    if (filter.count) {
        
        return filter.firstObject;
    } else {
        return nil;
    }
}

#pragma DataSours and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.serverProducts.count > 0 ? self.products.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [ProductForOrderTableViewCell getCellForTableView: tableView andClassCellString: @"ProductForOrderTableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductForOrderTableViewCell *displayCell = (ProductForOrderTableViewCell *)cell;
    DProductModel *activeProduct = [self getProductWhithID: self.products[indexPath.row].productID];
    displayCell.NameLabel.textColor = SYSTEM_NAV;
    if (activeProduct) {
        displayCell.NameLabel.text = activeProduct.productName;
        displayCell.pointLabel.text = [NSString stringWithFormat:@"%1.1f руб.", activeProduct.productPoint];
        displayCell.dateLabel.text = activeProduct.expires;
    }else{
        
        displayCell.NameLabel.text = @"Акция недоступна";
        displayCell.pointLabel.text = @"";
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DProductModel *activeProduct = [self getProductWhithID: self.products[indexPath.row].productID];
    
    if (activeProduct) {
        
        [self.navigationController pushViewController:[DSingleProductController openSingleProduct: activeProduct] animated:YES];
    }
}
@end
