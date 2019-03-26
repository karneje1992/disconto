//
//  DInProgressTableViewController.m
//  Disconto
//
//  Created by Ross on 31.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DInProgressTableViewController.h"

@interface DInProgressTableViewController ()

@property NSMutableArray<DHistoryModel *> *modelsArray;
@end

@implementation DInProgressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.modelsArray = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",apiPending] withCallBack:^(BOOL success, NSDictionary *resault) {
        for (NSDictionary *list in resault[kServerData]) {
            
            [self.modelsArray addObject:[[DHistoryModel alloc] initWithDictionary:list]];
        }
        [self.tableView reloadData];
    }];
    
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
    [cell.statusImageView sd_setImageWithURL:[NSURL URLWithString:self.modelsArray[indexPath.row].checktab]
                            placeholderImage:nil
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       // [cell.progress setAlpha:0];
                                   }];
    cell.status.text = @"В обработке";
    cell.chakNumber.text = [NSString stringWithFormat:@"Чек №: %@",@(self.modelsArray[indexPath.row].historyID)];
    [cell.dateLabel setText:self.modelsArray[indexPath.row].dateHistory];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

@end
