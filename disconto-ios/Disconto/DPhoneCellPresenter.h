//
//  DPhoneCellPresenter.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPhoneTableViewCell.h"
#import "DPhoneCellPresenterProtocol.h"
#import "DPhoneCellRouteProtocol.h"
#import "DPhoneCellIteratorProtocol.h"

@interface DPhoneCellPresenter : NSObject<DPhoneCellPresenterProtocol,UITextFieldDelegate>

@property DPhoneTableViewCell *view;
@property id<DPhoneCellRouteProtocolOutput> route;
@property id<DPhoneCellIteratorProtocol> iterator;
- (instancetype)initWithView:(DPhoneTableViewCell *)cell route:(id<DPhoneCellRouteProtocol>)route iterator:(id<DPhoneCellIteratorProtocol>)iterator;
@end
