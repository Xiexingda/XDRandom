//
//  ViewController.m
//  XDRandomDemo
//
//  Created by 谢兴达 on 2016/11/23.
//  Copyright © 2016年 谢兴达. All rights reserved.
//

#import "ViewController.h"
#import "XDRandomCutNumber.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建一个用于盛放返回的随机数的数组
    NSArray *randomArray = [NSArray array];
    
    /*
        例如我们要把 1000 随机分成 10 并让其波动范围在 20% 以内
     */
    randomArray = [[XDRandomCutNumber XD_randomNumber] XD_partsOfDistribution:10
                                                   totalNumberUsedToDistribut:1000
                                                                foloatPercent:20];
    //打印该数组
    NSLog(@"%@",randomArray);
    
    
    /***  执行测试程序  ***/
    /*
        把 10000 随机分成 10 份 并让浮动范围在 50% 以为，执行 1000 次
     */
   /* 
    
    [[XDRandomCutNumber XD_randomNumber] XD_testTimeNumbers:1000
                                                partsNumber:10
                                         totalNumberForTest:10000
                                             percentForTest:50];
    */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
