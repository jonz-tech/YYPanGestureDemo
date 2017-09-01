//
//  ViewController.m
//  YYPanGestureDemo
//
//  Created by zhuangchubin on 2017/9/1.
//  Copyright © 2017年 zhuangchubin. All rights reserved.
//

#import "ViewController.h"
#import "YYPanGestureModule.h"
@interface ViewController ()
{
    YYPanGestureModule *panModule;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    panModule = [YYPanGestureModule addPanGestureInView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
