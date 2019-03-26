//
//  DTextTableViewCellIterator.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTextTableViewCellIteratorProtocol.h"

@interface DTextTableViewCellIterator : NSObject<DTextTableViewCellIteratorProtocol>

@property (nonatomic) NSString *textValue;
@end
