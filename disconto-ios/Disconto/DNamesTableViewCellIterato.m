//
//  DNamesTableViewCellIterato.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DNamesTableViewCellIterato.h"

@implementation DNamesTableViewCellIterato

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.firstName = @"";
        self.secondName = @"";
        self.lastName = @"";
    }
    return self;
}

- (void)setFirstNameValue:(NSString *)firstName{

    self.firstName = firstName;
}

- (void)setSecondNameValue:(NSString *)secondName{

    self.secondName = secondName;
}

- (void)setLastNameValue:(NSString *)lastName{

    self.lastName = lastName;
}

- (NSString *)getFirstName{

    return self.firstName;
}

- (NSString *)getSecondName{

    return self.secondName;
}

- (NSString *)getLastName{

    return self.lastName;
}
@end
