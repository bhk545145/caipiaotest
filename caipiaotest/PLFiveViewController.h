//
//  PLFiveViewController.h
//  LotteryApp
//
//  Created by yuanda on 13-4-10.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "numberCell.h"
#import "kaiJiangCell.h"
#import "kaijiangModel.h"
#import "shakedViewCell.h"
#import "EGORefreshTableHeaderView.h"

@interface PLFiveViewController : UIViewController<numberCellDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    UILabel             *_titleLabel;           //nav上排列类型标题
    UIButton            *_shakeButton;          //摇一摇按钮
    
    UITableView         *_PLFiveTableView;      //直选tableview
    
    UIView              *_toolbarView;          //底部清空和确定按钮
    UILabel             *_numberNots;           //共几注
    UILabel             *_totalMoney;           //共多少钱
    
    UIView              *_openLotteryView;      //开奖下拉列表
    UITableView         *_kaiJiangTableView;    //开奖tableview
    NSInteger           totalNumberNots;        //所有注数
    UILabel             *_dangQianQi;           //当前第几期
    UIImageView         *_arrorImage;           //当前日期旁边的图标
    BOOL                _open_lotteryView;      //是否打开中奖详情
    
    kaijiangModel       *_kaiJiangQiHao;        //开奖期号
    NSMutableArray      *_kaijiangArray;        //前5期开奖信息保存在此数组中
    NSMutableArray      *_shakeNumber;          //摇一摇机选数
    NSMutableArray      *_makeSureSelectNumArray;//确定选好的号码
    BOOL                _refreshData;           //是否刷新数据
    
    EGORefreshTableHeaderView   *_refreshView;  //上拉刷新
    BOOL                isRefresh;
}

@end
