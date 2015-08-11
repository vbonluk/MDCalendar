//
//  MDCalendarViewController.m
//  MDCalendarDemo
//
//  Created by Michael Distefano on 5/23/14.
//  Copyright (c) 2014 Michael DiStefano
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "MDCalendarViewController.h"
#import "MDCalendar.h"
#import "NSDate+MDCalendar.h"
#import "UIColor+MDCalendarDemo.h"

@interface MDCalendarViewController () <MDCalendarDelegate>
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@property (nonatomic, assign) NSDate *firstDayOfStartMonth;
@property (nonatomic, strong) MDCalendar *calendarView;
@end

@implementation MDCalendarViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        MDCalendar *calendarView = [[MDCalendar alloc] init];
        
        calendarView.backgroundColor = [UIColor whiteColor];
        
        calendarView.lineSpacing = 0.f;
        calendarView.itemSpacing = 0.0f;
        calendarView.borderColor = [UIColor mightySlate];
        calendarView.borderHeight = 1.f;
        calendarView.showsBottomSectionBorder = YES;
        
        calendarView.textColor = [UIColor mightySlate];
        calendarView.headerTextColor = [UIColor mightySlate];
        calendarView.weekdayTextColor = [UIColor grandmasPillow];
        calendarView.cellBackgroundColor = [UIColor whiteColor];
        
        calendarView.highlightColor = [UIColor pacifica];
        calendarView.indicatorColor = [UIColor colorWithWhite:0.85 alpha:1.0];
        
        int timeInterval = -31536000;//一年的秒数
        
        NSDate *endDate = [NSDate date];
        NSDate *startDate = [NSDate dateWithTimeInterval:timeInterval sinceDate:endDate];
        
        calendarView.startDate = startDate;
        calendarView.endDate = endDate;
        calendarView.delegate = self;
        calendarView.canSelectDaysBeforeStartDate = NO;
        
        [self.view addSubview:calendarView];
        self.calendarView = calendarView;
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(BackToReporiList)];
        
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    return self;
}

-(void)BackToReporiList{
    if (self.calendarView.selectedDate == nil || self.calendarView.selectedDateSecond == nil) {
        self.calendarView.selectedDate = [NSDate dateWithTimeIntervalSinceNow:0];
        self.calendarView.selectedDateSecond = self.calendarView.selectedDate;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(MDCalendarViewControllerBackToPraviousVC:)]) {
        [self.delegate MDCalendarViewControllerBackToPraviousVC:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_calendarView scrollCalendarToDate:_calendarView.endDate animated:YES];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _calendarView.frame = self.view.bounds;
    _calendarView.contentInset = UIEdgeInsetsMake([self.topLayoutGuide length], 0, [self.bottomLayoutGuide length], 0);
}

#pragma mark - MDCalendarViewDelegate

- (void)calendarView:(MDCalendar *)calendarView didSelectDate:(NSDate *)date {
    NSLog(@"Selected Date: %@", [date descriptionWithLocale:[NSLocale currentLocale]]);
}

- (BOOL) calendarView:(MDCalendar *)calendarView shouldShowIndicatorForDate:(NSDate *)date
{
    // show indicator for every 4th day
//    return [date day] % 4 == 1;
    return  NO;
}

@end
