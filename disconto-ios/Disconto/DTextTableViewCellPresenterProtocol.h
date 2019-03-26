//
//  DTextTableViewCellPresenterProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DTextTableViewCellPresenterProtocol <NSObject>

- (void)updateUI;
- (void)setPlaceholder:(NSString *)string;

@end
