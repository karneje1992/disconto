//
//  DSelectorModel.m
//  Disconto
//
//  Created by user on 28.06.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSelectorModel.h"

@implementation DSelectorModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.productsArray = @[].mutableCopy;
        self.selectorCount = 0;
        self.photoArray = @[].mutableCopy;
        self.cellsArray = @[].mutableCopy;
    }
    return self;
}
@end
