//
//  DPostCodeTableViewCellIterator.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPostCodeTableViewCellIteratorProtocol.h"

@interface DPostCodeTableViewCellIterator : NSObject<DPostCodeTableViewCellIteratorProtocol>

@property (nonatomic) NSString *codeIndex;
@end
