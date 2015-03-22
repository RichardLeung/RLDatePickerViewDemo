//
//  ViewController.m
//  RLDatePickerViewDemo
//
//  Created by 梁原 on 15/3/22.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "ViewController.h"
#import "RLDatePickerView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonDate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonDateClick:(id)sender {
    
    RLDatePickerView *datePickerView =[[[NSBundle mainBundle]loadNibNamed:@"RLDatePickerView" owner:self options:nil] lastObject];
    __weak ViewController *weakself =self;
    [datePickerView initWithTitle:@"选择日期"
                          maxDate:[NSDate date]
                          minDate:[NSDate dateWithTimeIntervalSinceNow:-3600*24*365*20]
                       selectDate:[NSDate date]
                         callback:^(NSDate *selectedDate) {
                             [weakself.buttonDate setTitle:[[NSString stringWithFormat:@"%@",selectedDate] substringToIndex:10] forState:UIControlStateNormal];
    }];
    [datePickerView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
