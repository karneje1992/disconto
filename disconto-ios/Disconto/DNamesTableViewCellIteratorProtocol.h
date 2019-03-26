//
//  DNamesTableViewCellIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DNamesTableViewCellIteratorProtocol <NSObject>

- (void)setFirstNameValue:(NSString *)firstName;
- (void)setSecondNameValue:(NSString *)secondName;
- (void)setLastNameValue:(NSString *)lastName;
- (NSString *)getFirstName;
- (NSString *)getSecondName;
- (NSString *)getLastName;
@end
