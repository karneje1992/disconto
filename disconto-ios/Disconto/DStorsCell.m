//
//  DStorsCell.m
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DStorsCell.h"

@implementation DStorsCell

- (void)shopsProduct:(DProductModel *)product withIndexPath:(NSIndexPath *)indexPath{

    if (2*indexPath.row+1 <= product.stores.count-1) {
        
        DShopModel *shop1 = product.stores[2*indexPath.row];
        DShopModel *shop2 = product.stores[2*indexPath.row+1];
        [self.rightLabel setText:shop1.shopName];
        [self.leftLabel setText:shop2.shopName];
        return;
    }
    if (indexPath.row*2 < product.stores.count) {
        DShopModel *shop1 = product.stores[2*indexPath.row];
        [self.leftLabel setText:shop1.shopName];
    }
}

@end
