//
//  JYCycleGradientLayer.m
//  CircleGradientLayer
//
//  Created by  wuhiwi on 2017/8/2.
//  Copyright © 2017年 huijiayou.com. All rights reserved.
//

#import "JYCycleGradientLayer.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度

//参考链接: http://blog.csdn.net/zhoutao198712/article/details/20864143

@interface JYCycleGradientLayer ()

//背景圆环layer
@property (nonatomic, strong) CAShapeLayer *trackLayer;
//进度layer
@property (nonatomic, strong) CAShapeLayer *progressLayer;
//计时器
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat strokenEnd;

@end

@implementation JYCycleGradientLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.strokenEnd = 0;
    
    [self initSubView];
    
    [self addProgressTimer];
    return self;
}

- (void)initSubView
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2) radius:(self.frame.size.width-PROGRESS_LINE_WIDTH)/2 startAngle:degreesToRadians(-240) endAngle:degreesToRadians(60) clockwise:YES];
    
    
    //背景圆环layer
    self.trackLayer = [CAShapeLayer layer];
    self.trackLayer.path = path.CGPath;
    self.trackLayer.fillColor = [UIColor clearColor].CGColor;
    //线的颜色
    self.trackLayer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.6].CGColor;
    //线宽
    self.trackLayer.lineWidth = PROGRESS_LINE_WIDTH;
    //透明度
    self.trackLayer.opacity = 0.25;
    //指定线的边缘是圆的
    self.trackLayer.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:self.trackLayer];
    
    
    //进度layer
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.path = path.CGPath;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor redColor].CGColor;
    self.progressLayer.lineWidth = PROGRESS_LINE_WIDTH;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.strokeEnd = 0.0;
    
    CALayer *gradientLayer = [CALayer layer];
    gradientLayer.anchorPoint = CGPointMake(0, 0);
    gradientLayer.position = CGPointMake(0, 0);
    gradientLayer.frame = self.bounds;
    
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height);
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[self hexChangeFloat:@"fde802"].CGColor, nil]];
    [gradientLayer1 setLocations:@[@0.5,@0.9,@1 ]];
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 1)];
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 0)];
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
    [gradientLayer2 setLocations:@[@0.1,@0.5,@1]];
    gradientLayer2.frame = CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height);
    [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[self hexChangeFloat:@"fde802"].CGColor,[UIColor blueColor].CGColor , nil]];
    [gradientLayer2 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer2 setEndPoint:CGPointMake(0.5, 1)];
    [gradientLayer addSublayer:gradientLayer2];
    
    
    [self.layer addSublayer:gradientLayer];
    gradientLayer.mask = self.progressLayer;
}

//计时器事件
- (void)addProgressTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(progressGrow) userInfo:nil repeats:YES];
    [self.timer fire];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    [self.progressLayer addAnimation:animation forKey:nil];
}

- (void)progressGrow
{
    self.strokenEnd += 0.005;
    self.strokenEnd = self.strokenEnd >= 1 ? 1 : self.strokenEnd;
    
    self.progressLayer.strokeEnd = self.strokenEnd;
}

- (UIColor *)hexChangeFloat:(NSString *) hexColor {
    unsigned int redInt_, greenInt_, blueInt_;
    NSRange rangeNSRange_;
    rangeNSRange_.length = 2;  // 范围长度为2
    // 取红色的值
    rangeNSRange_.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
     scanHexInt:&redInt_];
    // 取绿色的值
    rangeNSRange_.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
     scanHexInt:&greenInt_];
    // 取蓝色的值
    rangeNSRange_.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
     scanHexInt:&blueInt_];
    return [UIColor colorWithRed:(float)(redInt_/255.0f)
                           green:(float)(greenInt_/255.0f)
                            blue:(float)(blueInt_/255.0f)
                           alpha:1.0f];
}


@end
