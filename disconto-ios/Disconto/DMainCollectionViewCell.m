//
//  DMainCollectionViewCell.m
//  Disconto
//
//  Created by user on 11.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DMainCollectionViewCell.h"

@implementation DMainCollectionViewCell

+ (id)getCellForTableView:(UICollectionView *)collectionView andClassCellString:(NSString *)classCell andIndexPath:(NSIndexPath *)indexPath{

    [collectionView registerNib:[UINib nibWithNibName:classCell bundle:nil] forCellWithReuseIdentifier:classCell];
    return [collectionView dequeueReusableCellWithReuseIdentifier:classCell forIndexPath:indexPath];
}
@end
