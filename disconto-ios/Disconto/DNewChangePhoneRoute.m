//
//  DNewChangePhoneRoute.m
//  Disconto
//
//  Created by Rostislav on 6/15/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DNewChangePhoneRoute.h"
#import "DNewChangePhoneViewController.h"
#import "DNewChangePhoneIterator.h"

@implementation DNewChangePhoneRoute

- (instancetype)initRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self) {
        
        self.rootViewController = rootViewController;
    }
    return self;
}

- (void)showChangePhoneModuleWithRootController:(UIViewController *)rootViewController {
    
     [DNewChangePhoneViewController showChangePhoneControllerCallBack:^(DNewChangePhoneViewController *resault) {
         dispatch_async(dispatch_get_main_queue(), ^(void){
             
             self.view = resault;
             self.presenter = [[DNewChangePhonePresenter alloc] initWithRoute:(id)self iterator:[DNewChangePhoneIterator new] view:self.view];
             
             if (self.rootViewController.navigationController != nil) {
                 
                 [self.rootViewController.navigationController pushViewController:self.presenter.view animated:YES];
             }else{
             
             }
         });

    }];

}
@end
