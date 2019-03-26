//
//  DLocalOfferRoute.m
//  Disconto
//
//  Created by Rostislav on 10.08.17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DLocalOfferRoute.h"
#import "DLocalOfferPresenter.h"
#import "DLocalOffeIterator.h"

@interface DLocalOfferRoute ()

@property UIViewController *viewController;
@property DLocalOfferPresenter *presenter;
@property DLocalOffeIterator *iterator;

@end

@implementation DLocalOfferRoute

+ (void)activeLocalOfferWithMoc:(DOfferModel *)moc viewController:(UIViewController *)viewController{
    
    id<DLocalOfferRouteProtocol> protocol = [DLocalOfferRoute new];
    [protocol showLocalOfferModuleWithMoc:moc viewController:viewController];
}

#pragma mark - DLocalOfferRouteProtocol

- (void)showLocalOfferModuleWithMoc:(DOfferModel *)moc viewController:(UIViewController *)viewController{

    self.viewController = viewController;
    self.iterator = [DLocalOffeIterator new];
    self.presenter = [[DLocalOfferPresenter alloc] initWith:self iterator:[DLocalOffeIterator new] view:[DLocalOfferViewController showDLocalOfferViewController]];
   
    if (self.viewController.navigationController) {
        
        [self.viewController.navigationController pushViewController:self.presenter.view animated:YES];
    } else {
        
        [self.viewController presentViewController:self.presenter.view animated:YES completion:nil];
    }
}
@end
