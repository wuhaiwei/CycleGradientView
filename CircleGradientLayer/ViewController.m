//
//  ViewController.m
//  CircleGradientLayer
//
//  Created by  wuhiwi on 2017/6/28.
//  Copyright © 2017年 huijiayou.com. All rights reserved.
//

#import "ViewController.h"
#import "JYCycleGradientLayer.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define PROGREESS_WIDTH 200 //圆直径

@interface ViewController ()

@property (nonatomic, strong) JYCycleGradientLayer *cycleGradientView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.cycleGradientView];
}

- (JYCycleGradientLayer *)cycleGradientView
{
    if (!_cycleGradientView) {
        _cycleGradientView = [[JYCycleGradientLayer alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - PROGREESS_WIDTH / 2, 200 - PROGREESS_WIDTH / 2, PROGREESS_WIDTH, PROGREESS_WIDTH)];
    }
    return _cycleGradientView;
}



@end
