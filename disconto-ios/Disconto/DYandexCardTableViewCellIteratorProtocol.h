//
//  DYandexCardTableViewCellIteratorProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DYandexCardTableViewCellIteratorProtocol <NSObject>

- (NSString *)getYandexCard;
- (void)setYandexNumberValue:(NSString *)yandexNumber;

@end
