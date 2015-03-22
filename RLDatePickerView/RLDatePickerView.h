//
//  RLDatePickerView.h
//  CococProject
//
//  Created by 梁原 on 15/3/17.
//  Copyright (c) 2015年 tempus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RLDatePickerViewSelectedDateBlock)(NSDate *selectedDate);

@interface RLDatePickerView : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet UIButton *buttonOK;

@property(nonatomic,strong)UIView *blurView;

@property (weak, nonatomic) IBOutlet UIToolbar *containView;

@property(nonatomic,strong)NSDate *dateSelected;
@property(nonatomic,strong)RLDatePickerViewSelectedDateBlock block;

-(void)initWithTitle:(NSString *)title
             maxDate:(NSDate *)maxDate
             minDate:(NSDate *)minDate
          selectDate:(NSDate *)selectedDate
            callback:(RLDatePickerViewSelectedDateBlock)block;

-(void)show;

-(void)dismiss;

@end
