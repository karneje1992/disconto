//
//  DDateTableViewCellPresenter.m
//  Disconto
//
//  Created by Rostislav on 7/3/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DDateTableViewCellPresenter.h"

@implementation DDateTableViewCellPresenter

- (instancetype)initWithRoute:(id<DDateTableViewCellRouteProtocol>)route iterator:(id<DDateTableViewCellIteratorProtocol>)iterator view:(DDateTableViewCell *)view
{
    self = [super init];
    if (self) {
        
        self.iterator = iterator;
        self.route = route;
        self.view = view;
        self.view.presenter = self;
        [self updateUI];
    }
    return self;
}

- (void)updateUI{

    [self delegates];
}

- (void)setTitle:(NSString *)title{

    [self.view.dateTitle setText:title];
}

- (void)delegates{
    
    [self.view.dayTextField setDelegate:self];
    [self.view.monthTextField setDelegate:self];
    [self.view.yearTextField setDelegate:self];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:)
         forControlEvents:UIControlEventValueChanged];
    [self.view.dayTextField setInputView:datePicker];
    [self.view.monthTextField setInputView:datePicker];
    [self.view.yearTextField setInputView:datePicker];
    
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(showSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    
    [self.view.dayTextField setInputAccessoryView:toolBar];
    [self.view.monthTextField setInputAccessoryView:toolBar];
    [self.view.yearTextField setInputAccessoryView:toolBar];
}

- (void)showSelectedDate{

    [self.iterator setDayValue:self.view.dayTextField.text];
    [self.iterator setMonthValue:self.view.monthTextField.text];
    [self.iterator setYearValue:self.view.yearTextField.text];
    [self.view endEditing:YES];
    
}

-(void)updateTextField:(UIDatePicker *)sender
{

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[sender date]];
    
    if ([components day] >= 10) {
        [self.view.dayTextField setText:[NSString stringWithFormat:@"%@",@([components day])]];
    }else{
    
        [self.view.dayTextField setText:[NSString stringWithFormat:@"0%@",@([components day])]];
    }
    
    if ([components month] >= 10) {
        [self.view.monthTextField setText:[NSString stringWithFormat:@"%@",@([components month])]];
    } else {
        [self.view.monthTextField setText:[NSString stringWithFormat:@"0%@",@([components month])]];
    }
    
    [self.view.yearTextField setText:[NSString stringWithFormat:@"%@",@([components year])]];
    
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField == self.view.dayTextField) {
        [self.iterator setDayValue:textField.text];
    } else if (textField == self.view.monthTextField){
        [self.iterator setMonthValue:textField.text];
    }else{
    
        [self.iterator setYearValue:textField.text];
    }

}
@end
