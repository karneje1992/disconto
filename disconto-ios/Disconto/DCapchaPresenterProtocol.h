//
//  DCapchaPresenterProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/28/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DCapchaPresenterProtocol <NSObject>

- (void)updateUI;

- (void)reloadAction;
- (void)sendCapcha;

@end

