//
//  XDRandomCutNumber.m
//  randomDeviceNumber
//
//  Created by 谢兴达 on 2016/11/21.
//  Copyright © 2016年 xiexingda. All rights reserved.
//

#import "XDRandomCutNumber.h"

@implementation XDRandomCutNumber

+ (XDRandomCutNumber *)XD_randomNumber {
    static XDRandomCutNumber *num;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        num = [[XDRandomCutNumber alloc]init];
    });
    return num;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

//把fnumber随机分成partsNumber份，并把随机的浮动范围限制在percent%以内，然后返回一个装有这些随机数的一个数组（元素为%.2f的形式的字符串）
- (NSArray *)XD_partsOfDistribution:(int)partsNumber totalNumberUsedToDistribut:(float)fnumber foloatPercent:(float)percent {
    
    NSMutableArray *randomArray = [[NSMutableArray alloc]init];
    //
    //不可变总数
    float changeLseeNumber = 0.0;
    //可变总数
    float changeNumber = 0.0;
    //总运气值
    float totalLuck = 0;
    //已经随机到的数的累加
    float totalNumber = 0.0;
    //浮动总数
    changeNumber = fnumber * (percent / 100.0);
    //将幸运指数浮动限定在20%以内后每份所分的数量；
    changeLseeNumber = (fnumber - changeNumber) / partsNumber;
    //用于盛放随机到的幸运值
    NSMutableArray *luckArray = [[NSMutableArray alloc]init];
    //给每人一个随机数，并求随机数总和
    for (int i = 0; i < partsNumber; i ++) {
        //分配一个【0 - 100】的随机数组
        luckArray[i] = @(arc4random()%101);
        //把随机数组里的所有数累加
        totalLuck += [luckArray[i] floatValue];
    }
    //每个人分到的随机数所占总随机数的百分比
    for (int j = 0; j < partsNumber; j ++) {
        //两种情况，当所有人都随机到0的时候按相等处理
        if (0 == totalLuck) {
            if (j == partsNumber - 1) {
                //最后一个数等于总数 - 前面所有数的和 *(重点细节，否则返回两位小数时会有0.01的偏差)  必须用ceilf（不小于算法）,消除前面的偏差
                NSString *everyNumberStr = [NSString stringWithFormat:@"%.2f", (int)ceilf((fnumber - totalNumber)*100)/100.0];
                [randomArray addObject:everyNumberStr];
            } else {
                float everyNumber = fnumber/partsNumber;
                NSString * everyStr = [NSString stringWithFormat:@"%.2f",(int)(everyNumber*100)/100.0];
                [randomArray addObject:everyStr];
                //已分得的总数
                totalNumber += [everyStr floatValue];
            }
            //当不是所有人都随机到 0 的时候
        } else {
            if (j == partsNumber - 1) {
                //最后一个数等于总数 - 前面所有数的和 *(重点细节，否则返回两位小数时会有0.01的偏差)  必须用roundf（四舍五入算法）,平衡前面的偏差
                NSString *everyNumberStr = [NSString stringWithFormat:@"%.2f", (int)roundf((fnumber - totalNumber)*100)/100.0];
                [randomArray addObject:everyNumberStr];
            } else {
                float everyNumber = changeLseeNumber + ([luckArray[j] floatValue]/totalLuck) * changeNumber;
                NSString * everyStr = [NSString stringWithFormat:@"%.2f",(int)(everyNumber*100)/100.0];
                [randomArray addObject:everyStr];
                //已分得的总数
                totalNumber += [everyStr floatValue];
            }
        }
    }
    
    return randomArray;
}

#pragma mark -
#pragma mark -- 测试随机分整

- (void)XD_testTimeNumbers:(int)times partsNumber:(int)parts totalNumberForTest:(float)number percentForTest:(float)percent {
    int x0 = 0;
    int x1 = 0;
    int x2 = 0;
    int x3 = 0;
    int x4 = 0;
    int x5 = 0;
    int x6 = 0;
    int x7 = 0;
    int x8 = 0;
    int x9 = 0;
    for (int i = 0; i < times; i ++) {
        float max = 0;
        int x  = 0;
        float total = 0.0;
        NSArray *array = [self XD_partsOfDistribution:parts totalNumberUsedToDistribut:number foloatPercent:percent];
        NSLog(@"%@",array);
        for (int n = 0; n < parts; n ++) {
            if (max < [array[n] floatValue]) {
                max = [array[n] floatValue];
                x = n;
            }
            total += [array[n] floatValue];
        }
        NSLog(@"total = %.2f",total);
        if (0 == x) {
            x0 ++;
        } else if(1 == x ) {
            x1 ++;
        } else if(2 == x) {
            x2 ++;
        } else if(3 == x) {
            x3 ++;
        } else if(4 == x) {
            x4 ++;
        } else if(5 == x) {
            x5 ++;
        } else if(6 == x) {
            x6 ++;
        } else if(7 == x) {
            x7 ++;
        } else if(8 == x) {
            x8 ++;
        } else if(9 == x) {
            x9 ++;
        }
        
    }
    NSLog(@"\n最大值:\n出现在第一位 %d 次\n出现在第二位 %d 次\n出现在第三位 %d 次\n出现在第四位 %d 次\n出现在第五位 %d 次\n出现在第六位 %d 次\n出现在第七位 %d 次\n出现在第八位 %d 次\n出现在第九位 %d 次\n出现在第十位 %d 次",x0,x1,x2,x3,x4,x5,x6,x7,x8,x9);
}

@end
