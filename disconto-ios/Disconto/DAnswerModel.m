//
//  DAnswerModel.m
//  Disconto
//
//  Created by user on 25.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DAnswerModel.h"

@implementation DAnswerModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.answerID = [dictionary[kID] integerValue];
        self.answerText = dictionary[@"text"];
    }
    return self;
}

@end