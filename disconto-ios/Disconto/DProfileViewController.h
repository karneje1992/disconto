//
//  DProfileViewController.h
//  Disconto
//
//  Created by user on 23.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface DProfileViewController : DSuperViewController

@property (strong, nonatomic) IBOutlet UIButton *photoButton;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
