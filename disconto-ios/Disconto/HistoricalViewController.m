//
//  HistoricalViewController.m
//  Disconto
//
//  Created by Rostyslav Didenko on 2/10/19.
//  Copyright © 2019 Disconto. All rights reserved.
//

#import "HistoricalViewController.h"
#import "MVVMDProductsViewController.h"
#import "DProductsVM.h"
#import "ProductsListViewController.h"

@interface HistoricalViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *stateControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) stateControl screenType;
@property NSMutableArray<DHistoryModel *> *modelsArray;
@property NSMutableArray<DHistoryModel *> *previewArray;

@end

@implementation HistoricalViewController

+ (instancetype)showHistoricalViewControllerWithControlType:(stateControl)stateControl{
    
    return [[HistoricalViewController alloc] initWithNibName:NSStringFromClass([HistoricalViewController class]) bundle:nil controlType: stateControl];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil controlType:(stateControl)stateControl {
    
    self = [super initWithNibName:nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        
        self.screenType = stateControl;
        self.modelsArray = @[].mutableCopy;
        [self loadModels];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SYSTEM_COLOR;
    [self.navigationController.navigationBar setBarTintColor:SYSTEM_NAV];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView = [UIImageView new];
    [self.stateControl setSelectedSegmentIndex: self.screenType];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
}

- (IBAction)changeViewAction:(UISegmentedControl *)sender {
    
    self.screenType = sender.selectedSegmentIndex;
 
    switch (self.screenType) {
        case 0:
            self.previewArray = [self confirmFilter].mutableCopy;
            break;
        case 1:
            self.previewArray = [self canceledFilter].mutableCopy;
            break;
            
        default:
            [self loadInProgress];
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.previewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DHistoryTableViewCell *cell = [DHistoryTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DHistoryTableViewCell class])];
    
    DHistoryModel *obj = self.previewArray[indexPath.row];
    
    [cell.status setText:obj.title];
    [cell.dateLabel setText:obj.dateHistory];
    if (obj.checktab.length > 1) {
        [cell.chakNumber setText:[NSString stringWithFormat:@"Чек № %@",obj.checktab]];
    }else{
        
        [cell.chakNumber setText:@""];
    }
    
    [cell.statusImageView sd_setImageWithURL:obj.imgURL];
    
    if (obj.point.floatValue > 0.0) {
        [cell.priceLabel setText:[NSString stringWithFormat:@"%@ руб.",obj.point]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DHistoryTableViewCell *displayCell = (DHistoryTableViewCell *)cell;
    DHistoryModel *obj = self.previewArray[indexPath.row];
    
    switch (obj.actionType) {
        case 1:
            [displayCell.priceLabel setText:[NSString stringWithFormat:@"%@ руб.",obj.point]];
            break;
            
        default:
            [displayCell.priceLabel setText:@""];
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.previewArray[indexPath.row].actionType == 1) {
        
        [self.navigationController pushViewController: [ProductsListViewController showOrderProducts: self.previewArray[indexPath.row].products] animated: YES];
    }else{
        
       // [self showTextAlert:self.previewArray[indexPath.row]];
        SHOW_MESSAGE(@"Чек", self.previewArray[indexPath.row].message)
    }
}

#pragma mark - Private

- (void)showTextAlert:(DHistoryModel *)item {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Чек" message:item.bodyText preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style: UIPreviewActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction: cancel];
    [self presentViewController: alert animated:YES completion: nil];
}

- (void)showOfferAlert:(DHistoryModel *)item {
    

    DProductModel *object = [item.products firstObject];
    __block NSString *dateString = object.expires;
    
    if (object.productID > 0) {
        
        [DProductsVM showProductsOfHisory:item];
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Чек принят" message:[NSString stringWithFormat:@"Акция была актуальна %@", dateString] preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style: UIPreviewActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction: cancel];
        
        [self presentViewController: alert animated:YES completion: nil];
    }
    
//    UIAlertAction *productAction = [UIAlertAction actionWithTitle: [NSString stringWithFormat:@"Акция %@", object.productName] style: UIPreviewActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        if ([self isEnabledOfferFronStringDate: dateString]) {
//
//            [alert dismissViewControllerAnimated:YES completion:^{
//
//                
//            }];
//        } else {
//
//            [alert dismissViewControllerAnimated:NO completion:^{
//                [UIView animateWithDuration:1.5 animations:^{
//
//                    [self showTextAlert: [NSString stringWithFormat:@"Акция окончена %@", dateString]];
//                }];
//            }];
//        }
//
//    }];
//    
//    [alert addAction: productAction];
//    

}

- (void)loadInProgress {
    
    self.previewArray = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",@"/history/pending"] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            for (NSDictionary *list in resault[kServerData]) {
                
                [self.previewArray addObject:[[DHistoryModel alloc] initWithDictionary:list]];
            }
        }
        [self.tableView reloadData];
    }];
}

- (void)loadModels {
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",apiHistory] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            for (NSDictionary *list in resault[kServerData]) {
                
                [self.modelsArray addObject:[[DHistoryModel alloc] initWithDictionary:list]];
            }
        }
        [self changeViewAction: (UISegmentedControl *)self.stateControl.gestureRecognizers.firstObject.view];
    }];
}

- (NSArray<DHistoryModel *> *)confirmFilter {
    
    NSArray<DHistoryModel *> *array = @[];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.actionType == 1"];
    array = [self.modelsArray filteredArrayUsingPredicate: predicate];
    return array;
}

- (NSArray<DHistoryModel *> *)canceledFilter {
    
    NSArray<DHistoryModel *> *array = @[];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.actionType == 3"];
    array = [self.modelsArray filteredArrayUsingPredicate: predicate];
    return array;
}

- (NSArray<DHistoryModel *> *)inProgressFilter {
    
    NSArray<DHistoryModel *> *array = @[];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.actionType == 0"];
    array = [self.modelsArray filteredArrayUsingPredicate: predicate];
    return array;
}
@end
