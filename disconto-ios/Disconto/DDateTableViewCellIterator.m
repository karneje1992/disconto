//
//  DDateTableViewCellIterator.m
//  Disconto
//
//  Created by Rostislav on 7/3/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DDateTableViewCellIterator.h"

@implementation DDateTableViewCellIterator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.day = @"";
        self.month = @"";
        self.year = @"";
    }
    return self;
}

- (void)setDayValue:(NSString *)day{

    self.day = day;
    
}

- (void)setMonthValue:(NSString *)month{

    self.month = month;
}

- (void)setYearValue:(NSString *)year{

    self.year = year;
}

- (NSString *)getDay{

    return self.day;
}

- (NSString *)getMonth{

    return self.month;
}

- (NSString *)getYear{

    return self.year;
}
@end
