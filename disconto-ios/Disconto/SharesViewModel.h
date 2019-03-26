//
//  SharesViewModel.h
//  Disconto
//
//  Created by Rostislav on 12/28/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareModel.h"
#import "DListTableViewCell.h"

@protocol SharesViewModelDelegate <NSObject>

- (void)viewModel:(id)ViewModel arrayFromServer:(NSArray *)array;

@end

@interface SharesViewModel : NSObject

@property id <SharesViewModelDelegate> delegate;
@property NSMutableArray<DListTableViewCell *> *cellsArray;
@property NSMutableArray<ShareModel *> *objectsArray;



- (void)updateTableView:(UITableView *)tableView;
@end
