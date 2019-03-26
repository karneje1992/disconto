//
//  DPaymentPresenter.h
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPaymentViewController.h"
#import "DPaymentPresenterProtocol.h"
#import "DPaymentRouteProtocol.h"
#import "DPaymentIteratorProtocol.h"
#import "DPhoneCellRoute.h"
#import "DPhoneCellRouteProtocol.h"
#import "DMoneyCellRouteProtocol.h"
#import "DMoneyCellRoute.h"
#import "DCardTableViewCellRoute.h"
#import "DCardTableViewCellRouteProtocol.h"
#import "DYandexCardTableViewCellRouteProtocol.h"
#import "DYandexCardTableViewCellRoute.h"
#import "DNamesTableViewCellRouteProtocol.h"
#import "DNamesTableViewCellRoute.h"
#import "DSerialTableViewCellRouteProtocol.h"
#import "DSerialTableViewCellRoute.h"
#import "DDateTableViewCellRouteProtocol.h"
#import "DDateTableViewCellRoute.h"
#import "DTextTableViewCellRouteProtocol.h"
#import "DTextTableViewCellRoute.h"
#import "DPostCodeTableViewCellRouteProtocol.h"
#import "DPostCodeTableViewCellRoute.h"


@interface DPaymentPresenter : NSObject<DPaymentPresenterProtocol, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate, TTTAttributedLabelDelegate,DPaymentIteratorProtocolOut>

@property DPaymentViewController *view;
@property id <DPaymentRouteDisableProtocol> route;
@property id <DPaymentIteratorProtocol> iterator;
@property id <DMoneyCellRouteProtocol> moneyCellModule;
@property id <DPhoneCellRouteProtocol> phoneCellModule;
@property id <DCardTableViewCellRouteProtocol> cardCellModule;
@property id <DYandexCardTableViewCellRouteProtocol> yandexModule;
@property id <DNamesTableViewCellRouteProtocol> namesModule;
@property id <DSerialTableViewCellRouteProtocol> pasportSerialModule;
@property id <DDateTableViewCellRouteProtocol> dateModule;
@property id <DTextTableViewCellRouteProtocol> passportDepartmant;
@property id <DDateTableViewCellRouteProtocol> pasportDateModule;
@property id <DTextTableViewCellRouteProtocol> birthdayAdressModule;
@property id <DTextTableViewCellRouteProtocol> registerAdressModule;
@property id <DTextTableViewCellRouteProtocol> cityAdressModule;
@property id <DTextTableViewCellRouteProtocol> adressModule;
@property id <DPostCodeTableViewCellRouteProtocol> postModule;

@property float comision;
@property CGFloat min;
@property CGFloat max;
@property NSArray *cells;
@property UIImageView *imageView;


- (void)showCodeWithMessage:(NSString *)message;

- (instancetype)initWithView:(DPaymentViewController *)view route:(id<DPaymentRouteDisableProtocol>)route iterator:(id<DPaymentIteratorProtocol>)iterator;
@end
