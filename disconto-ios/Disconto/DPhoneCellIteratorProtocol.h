//
//  DPhoneCellIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DPhoneCellIteratorProtocol <NSObject>

- (NSString *)getPhoneNumber;
- (void)setPhoneValue:(NSString *)phoneNumber;
@end
