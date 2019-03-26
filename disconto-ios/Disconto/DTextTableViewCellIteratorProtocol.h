//
//  DTextTableViewCellIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DTextTableViewCellIteratorProtocol <NSObject>

- (void)insertTextValue:(NSString *)textValue;
- (NSString *)getTextValue;

@end
