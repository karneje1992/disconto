//
//  DPostCodeTableViewCellIterator.m
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPostCodeTableViewCellIterator.h"

@implementation DPostCodeTableViewCellIterator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.codeIndex = @"";
    }
    return self;
}

- (void)setCodeIndexValue:(NSString *)codeIndex{

    self.codeIndex = codeIndex;
}

- (NSString *)getCodeIndex{

    return self.codeIndex;
}
@end
