//
//  DPaymentRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DPaymentRouteActiveProtocol <NSObject>

- (void)showModuleWithMin:(NSInteger)min max:(NSInteger)max comision:(float)comision imageView:(UIImageView *)imageView;
- (void)setParamsDictionary:(NSDictionary *)paramsDictionary;

@end

@protocol DPaymentRouteDisableProtocol <NSObject>

- (void)disableModule;
- (UIViewController *)getRootViewController;

@end
