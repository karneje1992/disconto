//
//  HistoricalViewController.h
//  Disconto
//
//  Created by Rostyslav Didenko on 2/10/19.
//  Copyright © 2019 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoricalViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

+ (instancetype)showHistoricalViewControllerWithControlType:(stateControl)stateControl;

@end

NS_ASSUME_NONNULL_END
