//
//  DDateTableViewCellIterator.h
//  Disconto
//
//  Created by Rostislav on 7/3/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDateTableViewCellIteratorProtocol.h"

@interface DDateTableViewCellIterator : NSObject<DDateTableViewCellIteratorProtocol>

@property (nonatomic) NSString *day;
@property (nonatomic) NSString *month;
@property (nonatomic) NSString *year;
@end
