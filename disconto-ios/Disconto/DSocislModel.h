//
//  DSocislModel.h
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSocislModel : NSObject

@property NSInteger socUuidFromServer;
@property NSString *socID;
@property NSString *socType;
@property BOOL isDeleteSoc;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
