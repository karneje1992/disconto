//
//  DTextTableViewCellIterator.m
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DTextTableViewCellIterator.h"

@implementation DTextTableViewCellIterator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textValue = @"";
    }
    return self;
}

- (void)insertTextValue:(NSString *)textValue{

    self.textValue = textValue;
}

- (NSString *)getTextValue{

    return self.textValue;
}
@end
