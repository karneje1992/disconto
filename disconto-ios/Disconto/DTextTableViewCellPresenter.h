//
//  DTextTableViewCellPresenter.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTextTableViewCellIteratorProtocol.h"
#import "DTextTableViewCell.h"
#import "DTextTableViewCellRouteProtocol.h"
#import "DTextTableViewCellPresenterProtocol.h"

@interface DTextTableViewCellPresenter : NSObject<UITextFieldDelegate,DTextTableViewCellPresenterProtocol>

@property DTextTableViewCell *view;
@property id <DTextTableViewCellIteratorProtocol> iterator;
@property id <DTextTableViewCellRouteProtocol> route;

- (instancetype)initWithRoute:(id<DTextTableViewCellRouteProtocol>)route iterator:(id<DTextTableViewCellIteratorProtocol>)iterator view:(DTextTableViewCell *)view;
@end
