//
//  DMainCollectionViewCell.h
//  Disconto
//
//  Created by user on 11.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMainCollectionViewCell : UICollectionViewCell

+ (id)getCellForTableView:(UICollectionView *)collectionView andClassCellString:(NSString *)classCell andIndexPath:(NSIndexPath *)indexPath;
@end
