//
//  HHViewController.m
//  HHUIKit
//
//  Created by MRCaoHH on 09/22/2017.
//  Copyright (c) 2017 MRCaoHH. All rights reserved.
//

#import "HHViewController.h"
#import <HHUIKit/HHTimerButton.h>

@interface HHViewController ()

@end

@implementation HHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"111");
    HHTimerButton *timerBtn = [[HHTimerButton alloc]initWithFrame:CGRectMake(100, 300, 100, 44)];
    [timerBtn setTitle:@"验证码" forState:UIControlStateNormal];
    [timerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    timerBtn.layer.cornerRadius = 3;
    timerBtn.layer.borderWidth = 0.5;
    timerBtn.layer.borderColor = [UIColor redColor].CGColor;
    [timerBtn setRefreshCallback:^(HHTimerButton *btn, NSTimeInterval interval, BOOL isPause) {
        [btn setTitle:[NSString stringWithFormat:@"%2.fS",btn.timeInterval -  interval] forState:UIControlStateDisabled];
        btn.layer.borderColor = [UIColor yellowColor].CGColor;
    }];
    [timerBtn setNormalStateButtonStyle:^(HHTimerButton *btn) {
        btn.layer.borderColor = [UIColor redColor].CGColor;
    }];
    [self.view addSubview:timerBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
