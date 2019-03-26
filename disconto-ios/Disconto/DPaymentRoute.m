//
//  DPaymentRoute.m
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPaymentRoute.h"


@interface DPaymentRoute ()

@property NSInteger type;
@property DPaymentViewController *view;
@property UIViewController *rootViewController;
@end

@implementation DPaymentRoute

+ (DPaymentRoute *)activeModuleWithType:(NSInteger)type rootViewController:(UIViewController *)rootViewController{

    return [[DPaymentRoute alloc] initWithType:type rootViewController:rootViewController];
}

- (instancetype)initWithType:(NSInteger)type rootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self) {
        
        self.type = type;
        self.rootViewController = rootViewController;
    }
    return self;
}

#pragma mark - DPaymentRouteActiveProtocol

- (void)showModuleWithMin:(NSInteger)min max:(NSInteger)max comision:(float)comision imageView:(UIImageView *)imageView{

    if (self.rootViewController) {
        
        if (self.rootViewController.navigationController) {
            
            _iterator = [[DPaymentIterator alloc] initWithType:self.type];
            _iterator.entity.minValue = min;
            _iterator.entity.maxValue = max;
            _iterator.entity.comision = comision;
     //       NSString *message = [NSString stringWithFormat:@"Комиссия платежной системы за перевод средств составит %@ %@ от суммы перевода",@(comision),@"%"];
       //     [[[UIAlertView alloc] initWithTitle:@"Дисконто" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            DPaymentViewController *view = [DPaymentViewController showPaymentViewController];
            DPaymentPresenter *presenter = [[DPaymentPresenter alloc] initWithView:view route:self iterator:_iterator];
            presenter.comision = comision;
            presenter.imageView.image = imageView.image;
            presenter.min = _iterator.entity.minValue = min;
            presenter.max = _iterator.entity.maxValue = max;
            [self.iterator setDelgate:presenter];
            [self.rootViewController.navigationController pushViewController:presenter.view animated:YES];
        }
    }
}

- (void)setParamsDictionary:(NSDictionary *)paramsDictionary{

    if (self.iterator) {
        [self.iterator setNewParams:paramsDictionary];
    }
    
}

#pragma mark - DPaymentRouteDisableProtocol

- (void)disableModule{

    [self.rootViewController.navigationController popViewControllerAnimated:YES];
}

- (UIViewController *)getRootViewController{

    return self.rootViewController;
}
@end
