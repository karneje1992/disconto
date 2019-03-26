//
//  DDescriptionCell.m
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DDescriptionCell.h"

@implementation DDescriptionCell

- (void)showSmallDescriptionFromProduct:(DProductModel *)product{

  //  [self.descriptionLabel setText:];
    [self parsURLsInString: product.descriptionProduct];
}

- (void)showFullDescriptionFromProduct:(DProductModel *)product{
    
//    [self.descriptionLabel setText:];
    [self parsURLsInString: product.fullDescription];
}

- (void)showLegal:(DProductModel *)product{
    
   // [self.descriptionLabel setText:];
    [self parsURLsInString: product.legalDescription];
}

- (void)parsURLsInString:(NSString *)string{
    
    [self.descriptionLabel setText: string];
    
    if (string) {
        
        NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        
        NSArray* matches = [detector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
        
        [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            NSRange range = [string rangeOfString:obj.URL.absoluteString];

            if (range.location != NSNotFound){

                
                [self.descriptionLabel setText: string];
                [self.descriptionLabel addLinkToURL:[NSURL URLWithString: obj.URL.absoluteString] withRange:range];

            }
        }];
    }

}
@end
