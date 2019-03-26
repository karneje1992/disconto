//
//  DProductHeaderCell.m
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DProductHeaderCell.h"

@implementation DProductHeaderCell

- (void)updateCell {
    
    //self.statusImageView.layer.cornerRadius = self.statusImageView.bounds.size.width*0.5;
    self.unlocedCountLabel.layer.masksToBounds = YES;
    self.unlocedCountLabel.layer.cornerRadius = self.unlocedCountLabel.bounds.size.width*0.5;
    [self.favoriteButton setImage:[UIImage imageNamed:_product.favorite? @"like_1":@"like_0"] forState:UIControlStateNormal];
    [self.productImageView  sd_setImageWithURL:self.product.productImageURL
                              placeholderImage:nil
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         // [cell.progress setAlpha:0];
                                     }];
    [self.statusImageView setAlpha:1];
    [self.unlocedCountLabel setAlpha:1];
    self.unlocedCountLabel.layer.cornerRadius = self.unlocedCountLabel.bounds.size.width*0.5;
    self.unlocedCountLabel.layer.borderColor = SYSTEM_COLOR.CGColor;
    self.unlocedCountLabel.layer.borderWidth = 1;
    if (self.product.status == 0) {
        
        [self.unlocedCountLabel setAlpha:0];
        [self.statusImageView setImage:[UIImage imageNamed:@"task_lock_0"]];
        self.statusImageView.layer.cornerRadius = self.statusImageView.bounds.size.width*0.5;
    }else{
        
        
        if (self.product.infinity) {
            [self.unlocedCountLabel setAlpha:0];
            [self.statusImageView setImage:[UIImage imageNamed:@"infinity"]];
            [self.statusImageView setAlpha:1];
            
        }else{
            [self.unlocedCountLabel setAlpha:1];
            self.unlocedCountLabel.layer.masksToBounds = YES;
            self.unlocedCountLabel.layer.cornerRadius = self.unlocedCountLabel.bounds.size.width*0.5;
            [self.statusImageView setAlpha:0];
            [self.unlocedCountLabel setText:[NSString stringWithFormat:@"%@",@(self.product.unlocedCount)]];
        }
    }
    
    if (self.product.unlocedCount < 1) {
        [self.statusImageView setImage:[UIImage imageNamed:@"infinity"]];
        [self.statusImageView setAlpha:1];
        [self.unlocedCountLabel setAlpha:0];
    }
    [self.favoriteCount setText:[NSString stringWithFormat:@"%@",@(self.product.totalFavorites)]];
}

- (IBAction)action:(id)sender {
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@/%@",apiAddToFavorite,@(self.product.productID)] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            [DProductModel updateProduct:self.product withCollBack:^(DProductModel *obj) {
                
                self.product = obj;
                self.product.favorite ? [self.favoriteButton setImage:[UIImage imageNamed:@"like_1"] forState:UIControlStateNormal] : [self.favoriteButton setImage:[UIImage imageNamed:@"like_0"] forState:UIControlStateNormal];
                [self updateCell];
            }];
        }
    }];
}

+ (DProductHeaderCell *)getHeaderWithProduct:(DProductModel *)product andTableView:(UITableView *)tableView{
    
    DProductHeaderCell *cell = [DProductHeaderCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DProductHeaderCell class])];
    cell.product = product;
    
    return cell;
}

@end
