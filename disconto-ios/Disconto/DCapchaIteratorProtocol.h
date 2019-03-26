//
//  DCapchaIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/28/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DCapchaIteratorProtocol <NSObject>

- (void)loadCapchaImageWithCallBack:(void (^)(NSDictionary *resault))callBack;
- (void)sendCapcha:(NSString *)capchaString;


@end
