//
//  DSocislModel.m
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSocislModel.h"

@implementation DSocislModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.socID = [NSString stringWithFormat:@"%@",@([dictionary[kSocID] integerValue])];
        self.socUuidFromServer = [dictionary[kID] integerValue];
        self.socType = dictionary[kSocType];
        self.isDeleteSoc = [dictionary[kSocID] isEqual:[NSNull null]] ? NO : [dictionary[kSocID] boolValue];
    }
    return self;
}
@end
