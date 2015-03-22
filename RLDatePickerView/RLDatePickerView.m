//
//  RLDatePickerView.m
//  CococProject
//
//  Created by 梁原 on 15/3/17.
//  Copyright (c) 2015年 tempus. All rights reserved.
//

#import "RLDatePickerView.h"

#define iOS7 [[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0 ? YES : NO
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight ((iOS7)?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.height - 20))
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@implementation RLDatePickerView
{
    NSDate * _maxDate;
    NSDate * _minDate;
}

-(void)initWithTitle:(NSString *)title
             maxDate:(NSDate *)maxDate
             minDate:(NSDate *)minDate
          selectDate:(NSDate *)selectedDate
            callback:(RLDatePickerViewSelectedDateBlock)block{
    self.backgroundColor =[UIColor clearColor];
    _maxDate =maxDate;
    _minDate =minDate;
    _labelTitle.text =title;
    _dateSelected =selectedDate;
    _block =block;
    
    _labelTitle.layer.cornerRadius = 5;
    _labelTitle.clipsToBounds = YES;
    _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    _containView.layer.cornerRadius = 5;
    _containView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.datePicker.layer.cornerRadius = 5;
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_buttonCancel setBackgroundImage:[self imageWithColor:_buttonCancel.backgroundColor] forState:UIControlStateNormal];
    _buttonCancel.backgroundColor = [UIColor whiteColor];
    _buttonCancel.layer.cornerRadius = 5;
    _buttonCancel.clipsToBounds = YES;
    _buttonCancel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_buttonOK setBackgroundImage:[self imageWithColor:_buttonOK.backgroundColor] forState:UIControlStateNormal];
    _buttonOK.backgroundColor = [UIColor whiteColor];
    _buttonOK.layer.cornerRadius = 5;
    _buttonOK.clipsToBounds = YES;
    _buttonOK.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_buttonCancel addTarget:self action:@selector(datePickerCancel:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonOK addTarget:self action:@selector(datePickerOK:)  forControlEvents:UIControlEventTouchUpInside];
    [_datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    [self createBlurView];
    
    [_datePicker setDate:selectedDate];
    [_datePicker setMinimumDate:_minDate];
    [_datePicker setMaximumDate:_maxDate];
}

-(void)createBlurView{
    self.blurView =[[UIView alloc]init];
    self.blurView.backgroundColor =RGBA(10, 10, 10, 0.6);
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.blurView addGestureRecognizer:tap];
}

-(void)datePickerCancel:(UIButton *)button{
    if (self.dateSelected) {
        self.block(self.dateSelected);
    }
    [self dismiss];
}

-(void)datePickerOK:(UIButton *)button{
    self.block(_datePicker.date);
    [self dismiss];
}

-(void)datePickerChange:(UIDatePicker *)datePicker{
    if ([datePicker.date timeIntervalSinceDate:_maxDate]>0) {
        [datePicker setDate:_maxDate animated:YES];
        return;
    }else if ([datePicker.date timeIntervalSinceDate:_minDate]<0){
        [datePicker setDate:_minDate animated:YES];
    }
}

-(void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.blurView setFrame:window.bounds];
    [window addSubview:self.blurView];
    self.blurView.alpha =0;
    //self.blurView.alpha =0.8;
    self.frame =CGRectMake(0, ScreenHeight, ScreenWidth,8*4+40*2+_datePicker.frame.size.height);
    self.alpha = 0;
    [window addSubview:self];
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.blurView.alpha = 1;
        self.alpha =1;
        [self setFrame:CGRectMake(0, ScreenHeight-self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    } completion:nil];
}

-(void)dismiss{
    __weak RLDatePickerView *weakself =self;
    [UIView animateWithDuration:0.4 animations:^{
        [weakself setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, self.frame.size.height)];
        weakself.alpha = 0;
        weakself.blurView.alpha =0;
    }completion:^(BOOL finished) {
        [weakself.blurView removeFromSuperview];
        weakself.blurView =nil;
        [weakself removeFromSuperview];
    }];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
