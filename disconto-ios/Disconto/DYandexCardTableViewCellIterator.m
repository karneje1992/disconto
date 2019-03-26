//
//  DYandexCardTableViewCellIterator.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DYandexCardTableViewCellIterator.h"

@implementation DYandexCardTableViewCellIterator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.yandexNumber = @"";
    }
    return self;
}

- (NSString *)getYandexCard{

    return self.yandexNumber;
}

- (void)setYandexNumberValue:(NSString *)yandexNumber{

    self.yandexNumber = yandexNumber;
}

@end
