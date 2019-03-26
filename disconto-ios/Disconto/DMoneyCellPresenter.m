//
//  DMoneyCellPresenter.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DMoneyCellPresenter.h"

@implementation DMoneyCellPresenter

- (instancetype)initWithView:(DMoneyTableViewCell *)view route:(id<DMoneyCellRouteProtocolOut>)route iterator:(id<DMoneyCellIteratorProtocol>)iterator
{
    self = [super init];
    if (self) {
        self.view = view;
        self.iterator = iterator;
        self.route = route;
        [self updateUI];
    }
    return self;
}

- (void)updateUI{

    self.view.moneyTextField.delegate = self;
    [self defaultFooter];

}

- (void)defaultFooter{

    NSMutableAttributedString *mainString = [[NSMutableAttributedString alloc] initWithString:[self labelMainText]];
    
    [mainString addAttribute:NSForegroundColorAttributeName
                       value:[self colorForHex:@"#6F7179"]
                       range:[[self labelMainText] rangeOfString:[self labelMainText]]];
    
    [mainString addAttribute:NSForegroundColorAttributeName
                       value:[SYSTEM_COLOR colorWithAlphaComponent:0.8]
                       range:[[self labelMainText] rangeOfString:[NSString stringWithFormat:@"%@%@",@([self.iterator getComision]),@"%"]]];
    [self.view.comisionLabel setAttributedText:mainString];
}

- (NSString *)labelMainText{

    return [NSString stringWithFormat:@"Комиссия платежной системы за перевод средств составит %@%@ от суммы перевода",@([self.iterator getComision]),@"%"];
}

- (void)nitificationEnabled{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (UIColor *)colorForHex:(NSString *)hexString{
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return UIColorFromRGB(rgbValue);
}

#pragma mark - keyboard movements

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = [self.route getTableView].frame;
        f.origin.y = -keyboardSize.height*0;
        [self.route getTableView].frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = [self.route getTableView].frame;
        f.origin.y = 0.0f;
        [self.route getTableView].frame = f;
    }];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{


    
    CGFloat resultComision = (([[NSString stringWithFormat:@"%@%@",textField.text,string] floatValue]) * ([self.iterator getComision]/100));
    NSString *comisionString = [NSString stringWithFormat:@"%.02f руб.",([[NSString stringWithFormat:@"%@%@",textField.text,string] floatValue]) - resultComision];
    
    NSString *worningString = @"";
    
    if (([[NSString stringWithFormat:@"%@%@",textField.text,string] floatValue]) < [self.iterator getMinValue]) {
        
        worningString = [NSString stringWithFormat:@"Сумма вывода должна быть больше %@ руб.\n",@([self.iterator getMinValue])];
        comisionString = @"";
        
    }else if (([[NSString stringWithFormat:@"%@%@",textField.text,string] floatValue]) > [self.iterator getMyMoney]) {
    
        worningString = @"Недостаточно средств!\n";
        comisionString = @"";
    }else if (([[NSString stringWithFormat:@"%@%@",textField.text,string] floatValue]) > [self.iterator getMaxValue]){
        
        worningString = [NSString stringWithFormat:@"Сумма должна быть меньше %@ руб.\n",@([self.iterator getMaxValue])];
        comisionString = @"";
    }
    
    
    NSString *labelString = [NSString stringWithFormat:@"%@%@\n На счет будет зачислено: %@",worningString,[self labelMainText], comisionString];
    
    NSMutableAttributedString *mainString = [[NSMutableAttributedString alloc] initWithString:labelString];
    
    [mainString addAttribute:NSForegroundColorAttributeName
                 value:[SYSTEM_COLOR colorWithAlphaComponent:0.8]
                 range:[labelString rangeOfString:comisionString]];
    
    [mainString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]
                       range:[labelString rangeOfString:worningString]];
    [mainString addAttribute:NSForegroundColorAttributeName
                       value:[SYSTEM_COLOR colorWithAlphaComponent:0.8]
                       range:[labelString rangeOfString:comisionString]];
   // [NSString stringWithFormat:@"Комиссия платежной системы за перевод средств составит %@%@ от суммы перевода",@([self.iterator getComision]),@"%"]
    [mainString addAttribute:NSForegroundColorAttributeName
                       value:[SYSTEM_COLOR colorWithAlphaComponent:0.8]
                       range:[labelString rangeOfString:[NSString stringWithFormat:@"%@%@",@([self.iterator getComision]),@"%"]]];
    
   
    [self.view.comisionLabel setAttributedText:mainString];
    
    if ((range.location-range.length) > 100) {
        
        [self defaultFooter];
        return YES;
    }
    
    if ([string isEqualToString:@""]) {
        
        return YES;
    }
    
    if (range.length) {
        
        [self.iterator setMoneyValue:[NSString stringWithFormat:@"%@%@",[textField.text stringByReplacingCharactersInRange:range withString:string],string]];
        
    } else {
        
        [self.iterator setMoneyValue:[NSString stringWithFormat:@"%@%@",textField.text,string]];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

  //  [self nitificationEnabled];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{


//    textField.text = [NSString stringWithFormat:@"%@",@([textField.text floatValue] - ([textField.text floatValue] * ([self.iterator getComision]/100)))];
    [self.iterator setMoneyValue:textField.text];
}
@end
