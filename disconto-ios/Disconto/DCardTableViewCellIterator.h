//
//  DCardTableViewCellIterator.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCardTableViewCellIteratorProtocol.h"

@interface DCardTableViewCellIterator : NSObject<DCardTableViewCellIteratorProtocol>

@property (nonatomic) NSString *cardNumber;
@end
