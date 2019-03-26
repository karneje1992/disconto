//
//  QRSelfViewController.m
//  Disconto
//
//  Created by Rostislav on 8/18/18.
//  Copyright © 2018 Disconto. All rights reserved.
//

#import "QRSelfViewController.h"
#import "DTextTableViewCellRoute.h"
#import "CCTextFieldEffects.h"

@interface QRSelfViewController () <QRSenderFooterViewDelegate, UITextFieldDelegate>

@property NSMutableArray<NSURLQueryItem *> *queryItems;
@property HoshiTextField *activeTextField;
@property UIDatePicker *datePicker;
@property DUserDataViewCell *activeCell;
@property NSIndexPath *activeIndexPath;


@end

@implementation QRSelfViewController

+ (instancetype)showCQRSelfViewController {
    
    return [[QRSelfViewController alloc] initWithNibName:NSStringFromClass([QRSelfViewController class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addKeyboardObservers];
    _queryItems = @[].mutableCopy;
    [self setTitle: @"Ручной ввод"];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *headerLabel = [UILabel new];
    headerLabel.text = @"Введите данные с чека";
    headerLabel.textColor = SYSTEM_COLOR;
    headerLabel.font = [UIFont systemFontOfSize:17];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    
    return headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [DUserDataViewCell getCellForTableView:tableView andClassCellString:@"DUserDataViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    QRSenderFooterView *footerView = [[QRSenderFooterView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 200.0)];
    footerView.delegate = self;
    return footerView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    switch (indexPath.row) {
        case 0:
            
            [self addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:@"Дата чека:" indexPath:indexPath];
            break;
        case 1:
            [self addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:@"Время чека:" indexPath:indexPath];
            break;
        case 2:
            [self addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:@"Сумма:" indexPath:indexPath];
            break;
        case 3:
            [self addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:@"ФН:" indexPath:indexPath];
            break;
        case 4:
            [self addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:@"ФД:" indexPath:indexPath];
            break;
            
        default:
            [self addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:@"ФПД:" indexPath:indexPath];
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

- (void)addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:(NSString *)placeholder indexPath:(NSIndexPath *)indexPath{
    
    
    // Recommended frame height is around 70.
    HoshiTextField *hoshiTextField = [[HoshiTextField alloc] initWithFrame:cell.textFildView.bounds];
    
    if (cell.textFildView.subviews.count) {
        
        return;
    }
    
    hoshiTextField.placeholder = placeholder;
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    //hoshiTextField.placeholderFontScale = 0.5;
    
    // The color of the inactive border, default value is R185 G193 B202
    hoshiTextField.borderInactiveColor = [UIColor blackColor];
    
    // The color of the active border, default value is R106 B121 B137
    hoshiTextField.borderActiveColor = [UIColor blackColor];
    
    // The color of the placeholder, default value is R185 G193 B202
    hoshiTextField.placeholderColor = [UIColor blackColor];
    
    // The color of the cursor, default value is R89 G95 B110
    hoshiTextField.cursorColor = [UIColor blueColor];
    
    // The color of the text, default value is R89 G95 B110
    hoshiTextField.textColor = [UIColor blackColor];
    
    switch (indexPath.row) {
        case 0:
            
            [self setDatePicker:hoshiTextField pickerMode:UIDatePickerModeDate];
            break;
        case 1:
            [self setDatePicker:hoshiTextField pickerMode:UIDatePickerModeTime];
            break;
            
        case 3:
          //  hoshiTextField.textColor = UIColor.redColor;
            [hoshiTextField setKeyboardType:(UIKeyboardTypeNumberPad)];
            break;
        case 4:
            [hoshiTextField setKeyboardType:(UIKeyboardTypeNumberPad)];
            break;
        case 5:
          //  hoshiTextField.textColor = UIColor.redColor;
            [hoshiTextField setKeyboardType:(UIKeyboardTypeNumberPad)];
            break;
            
        default:
            
            [hoshiTextField setKeyboardType:(UIKeyboardTypeNumbersAndPunctuation)];
            break;
    }
    
    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    hoshiTextField.didBeginEditingHandler = ^{
        
        self.activeTextField = hoshiTextField;
        self.activeCell = cell;
        self.activeIndexPath = indexPath;
        
        
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    hoshiTextField.didEndEditingHandler = ^{
        
        
    };
    
    hoshiTextField.delegate = self;
    
    [hoshiTextField addTarget:hoshiTextField
                       action:@selector(resignFirstResponder)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    hoshiTextField.returnKeyType = UIReturnKeyDone;
    // [hoshiTextField setClearButtonMode:UITextFieldViewModeAlways];
    
    
    [cell.textFildView addSubview:hoshiTextField];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    HoshiTextField *field = ((HoshiTextField *)textField);
    
    if ( [field.placeholder isEqualToString:@"Необходимо 16 символов"]){
        
        field.placeholder = @"ФН:";
        field.borderInactiveColor = [UIColor blackColor];
        field.placeholderColor = [UIColor blackColor];
        // SHOW_MESSAGE(nil, @"Необхадимо более 16 символов")
    }
    
    if ( [field.placeholder isEqualToString:@"Необходимо 10 символов"]){
        
        //  SHOW_MESSAGE(nil, @"Необхадимо более 10 символов")
        field.placeholder = @"ФПД:";
        field.placeholderColor = [UIColor blackColor];
        field.borderInactiveColor = [UIColor blackColor];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    HoshiTextField *field = ((HoshiTextField *)textField);
    
    if ( [textField.text length] < 16 && [field.placeholder isEqualToString:@"ФН:"]){
        
        field.placeholder = @"Необходимо 16 символов";
        field.borderInactiveColor = [UIColor redColor];
        field.placeholderColor = [UIColor redColor];
       // SHOW_MESSAGE(nil, @"Необхадимо более 16 символов")
    }
    
    if ( [textField.text length] < 10 && [field.placeholder isEqualToString:@"ФПД:"]){
        
      //  SHOW_MESSAGE(nil, @"Необхадимо более 10 символов")
        field.placeholder = @"Необходимо 10 символов";
        field.placeholderColor = [UIColor redColor];
        field.borderInactiveColor = [UIColor redColor];
    }
}

#pragma mark - Keyboard Observers

- (void)addKeyboardObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    
    CGRect frame = self.tableView.frame;
    frame.origin.y = -self.activeCell.bounds.size.height*2;
    
    [UIView animateWithDuration:0.3 animations:^{
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            self.tableView.frame = frame;
        });
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = frame;
    }];
}


- (void)setDatePicker:(HoshiTextField *)textField pickerMode:(UIDatePickerMode)mode{
    
    _datePicker = [[UIDatePicker alloc]init];
    [_datePicker setDate:[NSDate date]];
    [_datePicker setDatePickerMode: mode];
    [textField setInputView:_datePicker];
    
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(TextTitle:)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    
    [textField setInputAccessoryView:toolBar];
}

- (void)TextTitle:(id)sender {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    switch (((UIDatePicker *)self.activeTextField.inputView).datePickerMode) {
        case UIDatePickerModeDate:
            
            [df setDateFormat:@"YYYY-MM-d"];
            break;
            
        case UIDatePickerModeTime:
            
            [df setDateFormat:@"HH:mm"];
            break;
            
        default:
            break;
    }
    
    self.activeTextField.text = [NSString stringWithFormat:@"%@",
                                 [df stringFromDate:_datePicker.date]];
    [self.view endEditing:YES];
}

- (void)senderAction {
    
    [self.view endEditing:YES];
    _queryItems = @[].mutableCopy;
    
    __block BOOL showAlert = YES;
    __block NSString *timeString = @"";
    __block NSString *fn = @"";
    __block NSString *fd = @"";
    __block NSString *fpd = @"";
    __block NSString *sum = @"";
    
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof DUserDataViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([((HoshiTextField *)obj.textFildView.subviews.firstObject).text isEqualToString: @""]){
            
            if (showAlert) {
                SHOW_MESSAGE(@"", @"Все поля должны быть заполнены")
                showAlert = !showAlert;
            }
            
            return;
            
        }else {
            
            switch (idx) {
                case 0:
                    
                    timeString = [self getCutDate:((HoshiTextField *)obj.textFildView.subviews.firstObject).text];
                    break;
                    
                case 1:
                    
                    timeString = [NSString stringWithFormat:@"%@T%@", timeString, [self getCutTime: [self getCutDate:((HoshiTextField *)obj.textFildView.subviews.firstObject).text]]];
                    break;
                case 2:
                    
                    sum = ((HoshiTextField *)obj.textFildView.subviews.firstObject).text;
                    break;
                case 3:
                    
                    
                    
                    fn = ((HoshiTextField *)obj.textFildView.subviews.firstObject).text;
                    break;
                case 4:
                    
                    fd = ((HoshiTextField *)obj.textFildView.subviews.firstObject).text;
                    break;
                default:
                    
                    fpd = ((HoshiTextField *)obj.textFildView.subviews.firstObject).text;
                    
                    [_queryItems addObject: [[NSURLQueryItem alloc] initWithName: @"t" value: timeString] ];
                    [_queryItems addObject: [[NSURLQueryItem alloc] initWithName: @"s" value: sum] ];
                    [_queryItems addObject: [[NSURLQueryItem alloc] initWithName: @"fn" value: fn] ];
                    [_queryItems addObject: [[NSURLQueryItem alloc] initWithName: @"i" value: fd] ];
                    [_queryItems addObject: [[NSURLQueryItem alloc] initWithName: @"fp" value: fpd] ];
                    
                    [_queryItems addObject: [[NSURLQueryItem alloc] initWithName:@"n" value: @"1"]];
                    
                    NSURLComponents *urlComponent = [[NSURLComponents alloc] init];
                    [urlComponent setQueryItems:_queryItems];
                    
                    NSString *str = urlComponent.query;
                    [DScannerViewController sendToServerQrString: str];
                    break;
            }
        }
    }];
    
    
    
}

- (NSString *)getCutTime:(NSString *)inputString{
    
    return [inputString stringByReplacingOccurrencesOfString:@":" withString:@""];
}

- (NSString *)getCutDate:(NSString *)inputString{
    
    return [inputString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
@end

