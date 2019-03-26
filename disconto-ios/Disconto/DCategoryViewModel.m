//
//  DCategoryViewModel.m
//  Disconto
//
//  Created by Rostislav on 12/26/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DCategoryViewModel.h"
#import "DBannerTableViewCell.h"
#import "DSingleProductController.h"
#import "DOfferViewModel.h"
#import "DSingleOfferViewController.h"
#import "DSingleOfferViewModel.h"
#import "DBanerModel.h"

@interface DCategoryViewModel () <UIGestureRecognizerDelegate,DTutorialViewControllerDelegate>

@property NSMutableArray<NSString *> *banners;
@property NSMutableArray *cells;
@property NSArray<DBanerModel *> *bannerArray;
@property UIViewController *controller;
@end

@implementation DCategoryViewModel

- (instancetype)init

{
    self = [super init];
    if (self) {
        
        self.categoryArray = @[];
        self.banners = @[].mutableCopy;
        
        _bannerArray = @[];
        [DCategoryModel getAllCategoryWithCallBack:^(BOOL success, NSArray *resault) {
            
            self.categoryArray = resault;
            [self.delegate categoryDidFinihLoading:self];
        }];
        
        [DBanerModel getBanersWithCallBack:^(NSArray<DBanerModel *> *resault) {
            
            [resault enumerateObjectsUsingBlock:^(DBanerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self.banners addObject:obj.banerImageUrl.absoluteString];
                
            }];
            
            _bannerArray = resault;
            [self.delegate bannerDidFinishLoading:self];
            
        }];
    }
    return self;
}

- (void)updateController:(UIViewController *)controller{
    
    self.cells = @[].mutableCopy;
    self.cellsArray = @[];
    self.controller = controller;
    UITableView *tableView = [self getTableViewFromController:controller];
    [self inintCellsWithTableView:tableView];
    
    self.bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, (tableView.bounds.size.width/18*9))];
    
    if (self.banners.count) {
        MXBannerView *banner = [[MXBannerView alloc] initWithFrame:self.bannerView.bounds];
        [banner setShowPageControl:NO];
        [banner setAutoScrollTimeInterval:10];
        [banner setInfiniteScrollEnabled:YES];
        [banner setImageURLArray:[self.banners copy]];
        [banner setDelegate:self];
        [banner setAutoScrollEnabled:YES];
        banner.selectedDotColor = SYSTEM_COLOR;
        [[self bannerView] addSubview:banner];
    }
    
    
}

- (UITableView *)getTableViewFromController:(UIViewController *)controller{
    
    if (![controller.view isKindOfClass:[UITableView class]]) {
        for (UITableView *tableView in controller.view.subviews) {
            if ([tableView isKindOfClass:[UITableView class]]) {
                return tableView;
            }
        }
        return nil;
    }else
        
        return (UITableView *)controller.view;
}

- (void)inintCellsWithTableView:(UITableView *)tableView{
    
    [self.categoryArray enumerateObjectsUsingBlock:^(DCategoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        DCategoryTableViewCell *cell = [DCategoryTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DCategoryTableViewCell class])];
        cell.categoryLabel.text = obj.categoryName;
        if (idx) {
            
            [cell.categoryImageView sd_setImageWithURL:obj.categoryIcon];
            
            [cell.countNewLabel setText:[NSString stringWithFormat:@"%ld%@",(long)obj.newCount,kNew]];
            [cell.allDiscontoLabel setText:[NSString stringWithFormat:@"%ld%@",(long)obj.allCount,kDisconto]];
        }else{
            [cell.categoryImageView setImage:[UIImage imageNamed:@"top"]];
            [cell.countNewLabel setText:@""];
            [cell.allDiscontoLabel setText:@""];
        }
        
        [self.cells addObject:cell];
    }];
    
    self.cellsArray = self.cells;
}

- (void)bannerView:(MXBannerView *)bannerView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"%zd", index);
    
    [self.bannerArray[index] selectWithType:self controller:self.controller];
}

- (void)exitTutorialViewController:(id)controller{
    
    DTutorialViewController * vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];

}
@end
