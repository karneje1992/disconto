//
//  DPostCodeTableViewCellIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DPostCodeTableViewCellIteratorProtocol <NSObject>

- (void)setCodeIndexValue:(NSString *)codeIndex;
- (NSString *)getCodeIndex;

@end
