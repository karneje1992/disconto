//
//  DPhoneCellIterator.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPhoneCellIteratorProtocol.h"

@interface DPhoneCellIterator : NSObject<DPhoneCellIteratorProtocol>

@property (nonatomic) NSString *phoneNumber;
@end
