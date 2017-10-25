//
//  HHTimerButton.h
//  HHUIKit
//
//  Created by henry on 2017/9/22.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HHTimerButtonState) {
    HHTimerButtonState_Normal = 0,//正常
    HHTimerButtonState_Timing = 1,//倒计时中
    HHTimerButtonState_Pause = 2,//暂停
};

@interface HHTimerButton : UIButton
/**
 计时器状态
 */
@property (nonatomic,assign,readonly) HHTimerButtonState timerState;

/**
 恢复正常状态的时间间隔,默认60s
 */
@property (nonatomic,assign) NSTimeInterval timeInterval;

/**
 刷新按钮的时间间隔,默认1s
 */
@property (nonatomic,assign) NSTimeInterval refreshTimeInterval;

/**
 刷新按钮的回调,interval是当前计时,如果refreshCallback为空,默认HHTimerButton 显示 timeInterval - interval ,
 */
@property (nonatomic,copy) void(^refreshCallback)(HHTimerButton *btn,NSTimeInterval interval,BOOL isPause);

/**
 正常状态下按钮样式，默认nil
 */
@property (nonatomic,copy) void(^normalStateButtonStyle) (HHTimerButton *btn);

/**
 normalStateButtonStyle 不为空normalTitle失效
 */
@property (nonatomic,strong) NSString *normalTitle;

/**
 停止计时
 */
- (void)stopTiming;

/**
 开始计时
 */
- (void)startTiming;

/**
 暂停计时
 */
- (void)pauseTiming;

@end
