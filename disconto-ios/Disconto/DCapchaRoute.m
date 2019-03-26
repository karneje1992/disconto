//
//  DCapchaRoute.m
//  Disconto
//
//  Created by Rostislav on 7/28/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DCapchaRoute.h"
#import "DCapchaViewController.h"
#import "DCapchaIterator.h"

@implementation DCapchaRoute

- (void)showCapchaModuleWithRootVC:(UIViewController *)rootVC{

    DCapchaViewController *vc = [DCapchaViewController showCapchaViewController];
    self.presenter = [[DCapchaPresenter alloc] initWithRoute:self iterator:[DCapchaIterator new] view:vc];
    
    [rootVC presentViewController:self.presenter.view animated:YES completion:^{
        
//        [self.presenter.dataSourse loadCapchaImageWithCallBack:^(NSDictionary *resault) {
//            
//        }];
    }];    
}

- (void)dismiss{

    [self.presenter.view dismissViewControllerAnimated:YES completion:nil];
}
@end
