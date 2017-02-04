//
//  kaijiangModel.m
//  caipiaotest
//
//  Created by yuanda on 13-4-2.
//  Copyright (c) 2013年 wangjunjun. All rights reserved.
//

#import "kaijiangModel.h"

@implementation kaijiangModel
@synthesize lotteryDay;
@synthesize lotteryNum;


- (void)dealloc
{
    [lotteryDay release];
    [lotteryNum release];
    [super dealloc];
}
@end
