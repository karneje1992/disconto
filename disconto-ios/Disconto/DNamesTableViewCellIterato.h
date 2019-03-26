//
//  DNamesTableViewCellIterato.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNamesTableViewCellIteratorProtocol.h"

@interface DNamesTableViewCellIterato : NSObject<DNamesTableViewCellIteratorProtocol>

@property NSString *firstName;
@property NSString *secondName;
@property NSString *lastName;

@end
