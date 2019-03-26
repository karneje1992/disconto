//
//  DSerialTableViewCellIterator.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DSerialTableViewCellIterator.h"

@implementation DSerialTableViewCellIterator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pasportSirial = @"";
    }
    return self;
}

- (void)setPasportSirialValue:(NSString *)pasportSirial{

    self.pasportSirial = pasportSirial;
}

- (NSString *)getPasportSirial{

    return self.pasportSirial;
}
@end
