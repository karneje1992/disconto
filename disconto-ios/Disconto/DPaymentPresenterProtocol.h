//
//  DPaymentPresenterProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DPaymentPresenterProtocol <NSObject>

- (void)updateUI;
- (void)disableModule;
- (void)addRightButton;
@end
