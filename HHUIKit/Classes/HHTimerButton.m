//
//  HHTimerButton.m
//  HHUIKit
//
//  Created by henry on 2017/9/22.
//

#import "HHTimerButton.h"

@interface HHTimerButton(){
    NSInteger _count;//计时标志
}
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation HHTimerButton
@synthesize timer = _timer;

#pragma mark - 属性方法 -
- (NSTimer *)timer{
    if (_timer == nil) {
        //正常状态
        _timer = [NSTimer timerWithTimeInterval:self.refreshTimeInterval target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)setTimer:(NSTimer *)timer{
    if (_timer) {
        [self stop:_timer];
    }
    _timer = timer;
}

#pragma mark - 构造方法 -
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig{
    self.timeInterval = 5;
    self.refreshTimeInterval  = 1;
    _count = -1;
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self addTarget:self action:@selector(clickEvent) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 交互 -
- (void)clickEvent{
    [self startTiming];//开始计时
}

#pragma mark - 样式修改
- (void)timmingStyle{
    _timerState = HHTimerButtonState_Timing;
    self.enabled = NO;
    if (self.refreshCallback) {
        self.refreshCallback(self, [self currentInterval],NO);
        return;
    }
    
    NSTimeInterval interval = [self currentInterval];
    [self setTitle:[NSString stringWithFormat:@"%0.f",self.timeInterval - interval] forState:UIControlStateDisabled];
}


- (void)normalStyle{
    _timerState = HHTimerButtonState_Normal;
    self.enabled = YES;
    if (self.normalStateButtonStyle) {
        self.normalStateButtonStyle(self);
    }
}

- (void)pauseStyle{
    self.enabled = NO;
    _timerState = HHTimerButtonState_Pause;
    if (self.refreshCallback) {
        self.refreshCallback(self, [self currentInterval],YES);
        return;
    }
}

- (NSTimeInterval)currentInterval{
    return self.refreshTimeInterval * _count;
}

#pragma mark - 计时器控制 -
- (void)stopTiming{
    if (_timer) {
        [self stop:_timer];
        _count = -1;
        _timer = nil;
    }
    [self normalStyle];
}

- (void)startTiming{
    switch (_timerState) {
        case HHTimerButtonState_Normal:{
            //正常状态
            if (_timer) {
                _timer = nil;
            }
            [self start:self.timer];
        }
            break;
        case HHTimerButtonState_Pause:{
            //暂停
            [self start:_timer];
        }
            break;
        case HHTimerButtonState_Timing:{
            //计时中
        }
            break;
        default:
            break;
    }
    
    [self timmingStyle];
}

- (void)pauseTiming{
    if (_timerState == HHTimerButtonState_Timing) {
        [self stop:_timer];
    }
    [self pauseStyle];
}

- (void)runTimer{
    _count+=1;
    if ([self currentInterval] >= self.timeInterval) {
        [self stopTiming];
    }else{
        [self timmingStyle];
    }
}

#pragma mark - 计时器方法
- (void)stop:(NSTimer *)timer{
    [timer invalidate];
}

- (void)start:(NSTimer *)timer{
    [timer fire];
}


#pragma mark - 内存释放 -
- (void)dealloc{
}
@end
