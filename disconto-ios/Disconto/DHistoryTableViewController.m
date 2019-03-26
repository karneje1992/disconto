//
//  DHistoryTableViewController.m
//  Disconto
//
//  Created by Ross on 31.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DHistoryTableViewController.h"
#import "MVVMDProductsViewController.h"

@interface DHistoryTableViewController ()

@property NSMutableArray<DHistoryModel *> *modelsArray;
@end

@implementation DHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.modelsArray = @[].mutableCopy;
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",apiHistory] withCallBack:^(BOOL success, NSDictionary *resault) {
      
        if (success) {
            for (NSDictionary *list in resault[kServerData]) {
                
                [self.modelsArray addObject:[[DHistoryModel alloc] initWithDictionary:list]];
            }
            [self.tableView reloadData];
        }

    }];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DHistoryTableViewCell *cell = [DHistoryTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DHistoryTableViewCell class])];
    
    DHistoryModel *obj = self.modelsArray[indexPath.row];
    
    [cell.status setText:obj.title];
    [cell.dateLabel setText:obj.dateHistory];
    if (obj.checktab.length > 1) {
        [cell.chakNumber setText:[NSString stringWithFormat:@"Чек № %@",obj.checktab]];
    }else{
    
        [cell.chakNumber setText:@""];
    }
    
    [cell.statusImageView sd_setImageWithURL:obj.imgURL];
    if (obj.point.integerValue > 0) {
        [cell.priceLabel setText:[NSString stringWithFormat:@"%@ руб.",obj.point]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (self.modelsArray[indexPath.row].products.count) {
        
        if (self.modelsArray[indexPath.row].products[0].productID) {
            
            [DProductModel getNewAllProductsWithCollectionView:nil skip:self.modelsArray[indexPath.row].products[0].productID category:0 andCallBack:^(NSArray *array) {
                
                
                [self.navigationController pushViewController:[DSingleProductController openSingleProduct:array[0]] animated:YES];
            }];
        } else {
            
            MVVMDProductsViewController *vc = [MVVMDProductsViewController showProductsWithViewModel:[DProductsVM showProductsOfHisory:_modelsArray[indexPath.row]]];
            vc.title = self.modelsArray[indexPath.row].title;
            SHOW_MESSAGE(self.modelsArray[indexPath.row].bodyText, nil);
            [self.navigationController pushViewController:vc animated:YES];

        }

        
//                [self.navigationController pushViewController:[MVVMDProductsViewController showProductsWithViewModel:[DProductsVM showProductsOfHisory:_modelsArray[indexPath.row]]] animated:NO];
    }else{
    
        SHOW_MESSAGE(self.modelsArray[indexPath.row].message, self.modelsArray[indexPath.row].bodyText);
        
//            [[DSuperViewController new] showAlertWithTitle:self.modelsArray[indexPath.row].message message:;
    }

}
@end
