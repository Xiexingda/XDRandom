//
//  XDRandomCutNumber.h
//  randomDeviceNumber
//
//  Created by 谢兴达 on 2016/11/21.
//  Copyright © 2016年 xiexingda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDRandomCutNumber : NSObject

//单例
+ (XDRandomCutNumber *)XD_randomNumber;

/*
    partsNumber : 分成的分数
    fnumber     : 所要分割的总数
    percent     : 随机比例浮动范围（0~100，当为 0 时平均分配）
 */
//把fnumber随机分成partsNumber份，并把随机的浮动范围限制在percent%以内，然后返回一个装有这些随机数的一个数组（元素为%.2f的形式的字符串）
- (NSArray *)XD_partsOfDistribution:(int)partsNumber totalNumberUsedToDistribut:(float)fnumber foloatPercent:(float)percent;






//测试程序，一般不需要调用，只用于测试该随机分配的准确性 （亲测偏差在 0.002左右）
/*
    times : 测试次数 最好设置为1000以上
    parts : 分成的份数 （该测试程序只允许设置为 0 - 10）
    percent:浮动百分比 （0 - 100）
 
    注* 通过最大值出现在不同位置的次数来判断随机性的精确度(理论上出现在最后一位的可能性大一点，但影响不大，如果你想消除这点误差，那可以把得到的随机数组在随机分配)，出现在不同位置的次数越是接近越是精确
 */
- (void)XD_testTimeNumbers:(int)times partsNumber:(int)parts totalNumberForTest:(float)number percentForTest:(float)percent;
@end
