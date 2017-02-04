//
//  PLFiveViewController.m
//  LotteryApp
//
//  Created by yuanda on 13-4-10.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import "PLFiveViewController.h"
#define KAIJIANG_TABLEVIEW 3
#define PLFive_TABLEVIEW   2
@interface PLFiveViewController ()

@end

@implementation PLFiveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_shakeNumber release];
    [_makeSureSelectNumArray release];
    [_kaijiangArray release];
    [super dealloc];
}

#pragma mark--
#pragma mark - 自定义nav
- (void)goHome
{
    self.navigationController.navigationBarHidden = YES;
    
    UILabel *blackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    blackLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackLabel];
    [blackLabel release];
    
    UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 47)];
    imageView.image=[UIImage imageNamed:@"NavBar.png"];
    [self.view addSubview:imageView];
    [imageView release];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 47)];
    _titleLabel.text = @"排列5";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_titleLabel];
    [_titleLabel release];
    
    UIButton *backbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbut setImage:[UIImage imageNamed:@"NavButton.png"] forState:UIControlStateNormal];
    [backbut setImage:[UIImage imageNamed:@"NavButtonPressed.png"] forState:UIControlStateHighlighted];
    backbut.frame = CGRectMake(5, 7, 50, 30);
    backbut.titleLabel.textColor = [UIColor blackColor];
    [backbut addTarget:self action:@selector(pressedBackbut:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *backbutLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    backbutLabel.text = @"取消";
    backbutLabel.backgroundColor = [UIColor clearColor];
    backbutLabel.font = [UIFont systemFontOfSize:14];
    backbutLabel.textColor = [UIColor whiteColor];
    backbutLabel.textAlignment = NSTextAlignmentCenter;
    [backbut addSubview:backbutLabel];
    [backbutLabel release];
    [self.view addSubview:backbut];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setImage:[UIImage imageNamed:@"NavInfo.png"] forState:UIControlStateNormal];
    [nextBtn setImage:[UIImage imageNamed:@"NavInfoPressed.png"] forState:UIControlStateHighlighted];
    nextBtn.frame=CGRectMake(284, 7, 32, 30);
    [nextBtn addTarget:self action:@selector(pressedNextbut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    
    UIButton *selectStyleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectStyleButton.frame = CGRectMake(103, 0, 122, 43);
    [selectStyleButton addTarget:self action:@selector(pressedSelectStyleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectStyleButton];
}



#pragma mark -- nav 上取消按钮事件

- (void)pressedBackbut: (UIButton *)sender
{
    NSLog(@"fanhui");
}

#pragma mark -- nav 游戏规则按钮事件

- (void)pressedNextbut: (UIButton *)sender
{
    NSLog(@"游戏规则");
}


#pragma mark --
#pragma mark --  读取开奖数据
- (void)readKaiJiangData
{
    _kaijiangArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i<5; i++) {
        _kaiJiangQiHao = [[kaijiangModel alloc] init];
        _kaiJiangQiHao.lotteryDay = @"073";
        _kaiJiangQiHao.lotteryNum = @"556";
        [_kaijiangArray addObject:_kaiJiangQiHao];
        [_kaiJiangQiHao release];
    }
    
}

#pragma mark --
#pragma mark -- viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    _refreshData = NO ;
    self.view.backgroundColor = [UIColor blackColor];
    //读取中奖信息
    [self readKaiJiangData];
    
    //开启手机震动
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];

    //手机震动选号和清空数据会用到此数组
    _shakeNumber = [[NSMutableArray alloc] initWithCapacity:0];
    //用户确定
    _makeSureSelectNumArray = [[NSMutableArray alloc] init];
    
    [self addlottrtyNum];       //添加每期开奖号
    [self goHome];              //添加nav导航栏
    [self addTableview];        //添加选号cell
    [self addtoolBar];          //添加底部清空和确定
    
    
 
}

#pragma mark --
#pragma mark -- 添加每期开奖号

- (void)addlottrtyNum
{
    _openLotteryView = [[UIView alloc] initWithFrame:CGRectMake(0, -50, 320, 120)];
    _openLotteryView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:247.0/255.0 blue:239.0/255.0 alpha:1];
    //添加开奖期和开奖号
    CGRect rect = CGRectMake(0, 0, 107, 120);
    _kaiJiangTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _kaiJiangTableView.tag = KAIJIANG_TABLEVIEW;
    _kaiJiangTableView.dataSource = self;
    _kaiJiangTableView.delegate = self;
    _kaiJiangTableView.showsHorizontalScrollIndicator = NO;
    _kaiJiangTableView.showsVerticalScrollIndicator = NO;
    _kaiJiangTableView.scrollEnabled = NO;
    _kaiJiangTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _kaiJiangTableView.backgroundColor = [UIColor clearColor];
    UIView *bgview = [[UIView alloc] init];
    bgview.backgroundColor = [UIColor clearColor];
    [bgview release];
    [_openLotteryView addSubview:_kaiJiangTableView];
    [_kaiJiangTableView release];
    
    //添加当前期数和按钮
    UIImageView *_lineBreakImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MultiSepLine.png"]];
    _lineBreakImage.frame = CGRectMake(220, 93, 1, 26);
    [_openLotteryView addSubview:_lineBreakImage];
    [_lineBreakImage release];
    
    UILabel * _wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(224, 93, 80, 26)];
    _wordLabel.text = @"当前      期";
    _wordLabel.font = [UIFont systemFontOfSize:14];
    _wordLabel.backgroundColor = [UIColor clearColor];
    _wordLabel.textColor = [UIColor blackColor];
    [_openLotteryView addSubview:_wordLabel];
    [_wordLabel release];
    
    _dangQianQi = [[UILabel alloc] initWithFrame:CGRectMake(252, 93, 30, 26)];
    _dangQianQi.text = @"095";
    _dangQianQi.font = [UIFont systemFontOfSize:14];
    _dangQianQi.backgroundColor = [UIColor clearColor];
    _dangQianQi.textColor = [UIColor colorWithRed:160.0/255.0 green:14.0/255.0 blue:54.0/255.0 alpha:1];
    [_openLotteryView addSubview:_dangQianQi];
    [_dangQianQi release];
    
    _arrorImage = [[UIImageView alloc] initWithFrame:CGRectMake(295, 94, 22, 22)];
    _arrorImage.image = [UIImage imageNamed:@"RedDownArrow.png"];
    _arrorImage.backgroundColor = [UIColor clearColor];
    [_openLotteryView addSubview:_arrorImage];
    [_arrorImage release];
    
    UIButton *_lotteryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lotteryButton.frame = CGRectMake(221, 93, 95, 26);
    [_lotteryButton addTarget:self action:@selector(pressedLotteryButton:) forControlEvents:UIControlEventTouchUpInside];
    [_openLotteryView addSubview:_lotteryButton];
    _open_lotteryView = NO;
    
    _openLotteryView.layer.shadowColor = [UIColor blackColor].CGColor;
    _openLotteryView.layer.shadowOffset = CGSizeMake(1.5, 1.5);
    _openLotteryView.layer.shadowOpacity = 0.8;
    [_openLotteryView.layer setMasksToBounds:YES];
    
    [self.view addSubview:_openLotteryView];
    [_openLotteryView release];
}

- (void)pressedLotteryButton: (UIButton *)sender
{
    if (!_open_lotteryView ) {
        _arrorImage.image = [UIImage imageNamed:@"redUpArrow.png"];
        CGRect rect ;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            rect = CGRectMake(0, 70+93, 320, 434);
        }else{
            rect = CGRectMake(0, 70+93, 320, 346);
        }
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        _openLotteryView.frame = CGRectMake(0, 43, 320, 120);
        _PLFiveTableView.frame = rect;
        [UIView commitAnimations];
        _open_lotteryView = YES;
        
    }else
    {
        _arrorImage.image = [UIImage imageNamed:@"RedDownArrow.png"];
        CGRect rect ;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            rect = CGRectMake(0, 70, 320, 434);
        }else{
            rect = CGRectMake(0, 70, 320, 346);
        }
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        _openLotteryView.frame = CGRectMake(0, -50, 320, 120);
        _PLFiveTableView.frame = rect;
        [UIView commitAnimations];
        _open_lotteryView = NO;
    }
    
}


#pragma mark --
#pragma mark -- 添加选号cell

- (void)addTableview
{
    CGRect rect ;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        rect = CGRectMake(0, 70, 320, 433);
    }else{
        rect = CGRectMake(0, 70, 320, 405);
    }
    _PLFiveTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _PLFiveTableView.tag = PLFive_TABLEVIEW;
    _PLFiveTableView.alpha = 1;
   // _PLFiveTableView.contentSize = CGSizeMake(320, 25+90*5);
    _PLFiveTableView.dataSource = self;
    _PLFiveTableView.delegate = self;
    _PLFiveTableView.userInteractionEnabled = YES;
    _PLFiveTableView.bounces = YES;
    _PLFiveTableView.scrollEnabled = YES;
    _PLFiveTableView.showsHorizontalScrollIndicator = NO;
    _PLFiveTableView.showsVerticalScrollIndicator = NO;
    _PLFiveTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加footView，使得最后一行cell在iphone4上能滑动上来
    if ([[UIScreen mainScreen] bounds].size.height != 568) {
        UIView *_lastClearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        _lastClearView.backgroundColor = [UIColor clearColor];
        _PLFiveTableView.tableFooterView = _lastClearView;
        [_lastClearView release];
    }
    
    
    // 加入refreshView下拉刷新;
    CGRect refreshRect = CGRectMake(0.0f,
                                    0.0f-_PLFiveTableView.bounds.size.height,
                                    _PLFiveTableView.bounds.size.width,
                                    _PLFiveTableView.bounds.size.height);
    _refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:refreshRect];
    _refreshView.delegate = self;
    _refreshView.backgroundColor = [UIColor clearColor];
    [_PLFiveTableView addSubview:_refreshView];
    
    
    //设置背景
    //_PLFiveTableView.backgroundColor = [UIColor clearColor];
    UIView *bgview = [[UIView alloc] init];
    bgview.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:243.0/255.0 blue:238.0/255.0 alpha:1];
    _PLFiveTableView.backgroundView = bgview;
    [bgview release];
    [self.view addSubview:_PLFiveTableView];
    [_PLFiveTableView release];
    
}

#pragma mark --
#pragma mark -- 添加底部清空和确定

- (void)addtoolBar
{
    CGRect rect ;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        rect = CGRectMake(0, 504, 320, 44);
    }else{
        rect = CGRectMake(0, 416, 320, 44);
    }
    _toolbarView = [[UIView alloc] initWithFrame:rect];
    _toolbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ToolBarBackground.png"]];
    //清空按钮
    UIButton *_clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearButton setImage:[UIImage imageNamed:@"ToolBarRedButton.png"] forState:UIControlStateNormal];
    [_clearButton setImage:[UIImage imageNamed:@"ToolBarRedButtonPressed.png"] forState:UIControlStateHighlighted];
    _clearButton.frame = CGRectMake(9, 3.5, 58, 34);
    [_clearButton addTarget:self action:@selector(pressedClearBut:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarView addSubview:_clearButton];
    UILabel *_clearButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 34)];
    _clearButtonLabel.text = @"清空";
    _clearButtonLabel.backgroundColor = [UIColor clearColor];
    _clearButtonLabel.font = [UIFont boldSystemFontOfSize:18];
    _clearButtonLabel.textColor = [UIColor whiteColor];
    _clearButtonLabel.textAlignment = NSTextAlignmentCenter;
    [_clearButton addSubview:_clearButtonLabel];
    [_clearButtonLabel release];
    
    //确定按钮
    UIButton *_sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureButton setImage:[UIImage imageNamed:@"ToolBarRedButton.png"] forState:UIControlStateNormal];
    [_sureButton setImage:[UIImage imageNamed:@"ToolBarRedButtonPressed.png"] forState:UIControlStateHighlighted];
    _sureButton.frame = CGRectMake(255, 3.5, 58, 34);
    [_sureButton addTarget:self action:@selector(pressedSureBut:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarView addSubview:_sureButton];
    UILabel *_sureButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 34)];
    _sureButtonLabel.text = @"确定";
    _sureButtonLabel.backgroundColor = [UIColor clearColor];
    _sureButtonLabel.font = [UIFont boldSystemFontOfSize:18];
    _sureButtonLabel.textColor = [UIColor whiteColor];
    _sureButtonLabel.textAlignment = NSTextAlignmentCenter;
    [_sureButton addSubview:_sureButtonLabel];
    [_sureButtonLabel release];
    
    _numberNots = [[UILabel alloc] initWithFrame:CGRectMake(83, 0, 80, 43)];
    _numberNots.text = @"共0注";
    _numberNots.backgroundColor = [UIColor clearColor];
    _numberNots.font = [UIFont systemFontOfSize:16];
    _numberNots.textColor = [UIColor whiteColor];
    _numberNots.textAlignment = NSTextAlignmentRight;
    [_toolbarView addSubview:_numberNots];
    [_numberNots release];
    
    
    _totalMoney = [[UILabel alloc] initWithFrame:CGRectMake(168, 0, 80, 43)];
    _totalMoney.text = @"0元";
    _totalMoney.backgroundColor = [UIColor clearColor];
    _totalMoney.font = [UIFont systemFontOfSize:16];
    _totalMoney.textColor = [UIColor colorWithRed:215.0/255.0 green:180.0/255.0 blue:87.0/255.0 alpha:1];
    _totalMoney.textAlignment = NSTextAlignmentLeft;
    [_toolbarView addSubview:_totalMoney];
    [_totalMoney release];
    
    
    
    [self.view addSubview:_toolbarView];
    [_toolbarView release];
}


- (void)pressedSureBut: (UIButton *)sender
{
    NSLog(@"确定");
    _refreshData = NO;
    [_PLFiveTableView reloadData];
    for (NSInteger i = 0 ; i<5 ; i++ ) {
        NSMutableArray *tmpArr = [_makeSureSelectNumArray objectAtIndex:i];
        NSLog(@"%d位：%@",i,tmpArr);
        if ([tmpArr count] == 0) {
            NSString *_weiZhiStr ;
            switch (i) {
                case 0:
                    _weiZhiStr = [NSString stringWithFormat:@"请输入万位"];
                    break;
                case 1:
                    _weiZhiStr = [NSString stringWithFormat:@"请输入千位"];
                    break;
                case 2:
                    _weiZhiStr = [NSString stringWithFormat:@"请输入百位"];
                    break;
                case 3:
                    _weiZhiStr = [NSString stringWithFormat:@"请输入十位"];
                    break;
                case 4:
                    _weiZhiStr = [NSString stringWithFormat:@"请输入个位"];
                    break;
                default:
                    break;
            }
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:_weiZhiStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alertV show];
            [alertV release];
            return;
        }
        
    }
}


- (void)pressedClearBut: (UIButton *)sender
{
    NSLog(@"清空");
    _refreshData = YES;
    [_shakeNumber removeAllObjects];
    [_PLFiveTableView reloadData];
    _numberNots.text = @"共0注";
    _totalMoney.text = @"0元";
    
}

#pragma mark --
#pragma mark -- tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == PLFive_TABLEVIEW) {
        // return 4;
        return 6;
    }
    else if(tableView.tag == KAIJIANG_TABLEVIEW)
    {
        return 5;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == KAIJIANG_TABLEVIEW) {
        return 24;
    }else
    {
        if (indexPath.row == 0) {
            return 25;
        }
        else
        {
            return 90;
        }
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case (PLFive_TABLEVIEW):
        {
            if (indexPath.row == 0) {
                NSString *CellId = @"firstCell";
                shakedViewCell *cell = [[shakedViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:CellId withTitle:@"每位至少选择一个数字"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else
            {
                NSString *CellId = @"otherCell";
                numberCell* cell= [tableView dequeueReusableCellWithIdentifier:CellId];
                if (cell == nil) {
                    cell = [[numberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                switch (indexPath.row) {
                    case 1:
                        cell.zhiXuanLabel.text = @"万";
                        break;
                    case 2:
                        cell.zhiXuanLabel.text = @"千";
                        break;
                    case 3:
                        cell.zhiXuanLabel.text = @"百";
                        break;
                    case 4:
                        cell.zhiXuanLabel.text = @"十";
                        break;
                    case 5:
                        cell.zhiXuanLabel.text = @"个";
                        break;
                    default:
                        break;
                }
                if (_refreshData) {
                    //清空所有cell上数据
                    [cell refreshDataWith:@"清空数据"];
                     if ([_shakeNumber count] != 0)
                    {
                        //摇手机出现的随机数
                        NSString *selectNum =[_shakeNumber objectAtIndex:indexPath.row - 1];
                        NSLog(@"****************::%@",selectNum);
                        [cell refreshDataWith:selectNum];
                    }
                    
                    if (indexPath.row == 5) {
                        _refreshData = NO;
                    }
                }
                [_makeSureSelectNumArray addObject:cell.selectNumberArray];
                cell.delegate = self;
                return cell;
            }
            
        }
            break;
        case (KAIJIANG_TABLEVIEW):
        {
            NSString *CellId = @"kaijiangCell";
            kaiJiangCell* cell = nil;
            if (cell == nil) {
                cell = [[kaiJiangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            _kaiJiangQiHao = [_kaijiangArray objectAtIndex:indexPath.row];
            cell.kaijiangNum.text = _kaiJiangQiHao.lotteryNum;
            cell.kaijiangQi.text = _kaiJiangQiHao.lotteryDay;
            
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark --
#pragma mark -- NumberCellDelegate
//当前界面在选号时不可滑动，cell来控制
- (void)tableViewScrll:(BOOL)stop
{
    if (stop) {
        _PLFiveTableView.scrollEnabled = YES;
        NSLog(@"*****可滚动*****");
        
    }else
    {
        _PLFiveTableView.scrollEnabled = NO;
        NSLog(@"*****不可滚动*****");
        
    }
    
}

//选中或取消号码后产生的注数和钱数

- (void)getTotalNotsAndMoney
{
    NSInteger totalNumber = 1;
    [_PLFiveTableView reloadData];
    NSLog(@"数组%lu",(unsigned long)[_makeSureSelectNumArray count]);
    for (NSInteger i = 0; i<5; i++) {
        NSMutableArray *tmpArray = [_makeSureSelectNumArray objectAtIndex:i];
//        if ([tmpArray count] == 0) {
//            totalNumber = 0;
//            _numberNots.text = [NSString stringWithFormat:@"共%d注",totalNumber];
//            _totalMoney.text = [NSString stringWithFormat:@"%d元",totalNumber*2];
//            return;
//        }else
//        {
    totalNumber *= [tmpArray count];
//        }
    }
    _numberNots.text = [NSString stringWithFormat:@"共%d注",totalNumber];
    _totalMoney.text = [NSString stringWithFormat:@"%d元",totalNumber*2];
    NSLog(@"%d",totalNumber);
}

#pragma mark --
#pragma mark -- 摇一摇机选
- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    NSLog(@"检测到摇动");
    [_shakeNumber removeAllObjects];
    for (int i = 0; i<5; i++) {
        int j = arc4random()%10;
        NSString *selectNumStr = [NSString stringWithFormat:@"%d",j];
        [_shakeNumber addObject:selectNumStr];
        NSLog(@"selectNumStr:%@",selectNumStr);
    }
    NSLog(@"*_shakeNumber:%@",_shakeNumber);
    
    _refreshData = YES;
    [_PLFiveTableView reloadData];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"摇动取消");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"摇动结束");
    if (event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"UIEventSubtypeMotionShake---摇动结束");
      
        _numberNots.text = @"共1注";
        _totalMoney.text = @"2元";
       _refreshData = NO;
    }
}
#pragma mark --
#pragma mark -- UISrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //取消所有点击小球的背景图
    for (UIView *tmpView in [UIApplication sharedApplication].delegate.window.subviews) {
        if (tmpView.tag == 123456) {
            [tmpView removeFromSuperview];
        }
    }
    
    _refreshData = NO;
}


#pragma mark --
#pragma mark -- 下拉刷新

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /* 通知一下refreshView */
    [_refreshView egoRefreshScrollViewDidScroll:scrollView];
    /* 调用refreshView中的scrollViewDidScroll方法 */
}


- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    /* 开始更新代码放在这里 */
    isRefresh = YES;
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    /* 返给refreshView是否正在更新 */
    return isRefresh;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    /* refresh更新完成会调用该方法 设置更新时间 */
    return [NSDate date];
}


#pragma mark --
#pragma mark -- 下载近期开奖数据

- (void)loadingDataSource
{
    
    _kaijiangArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i<5; i++) {
        _kaiJiangQiHao = [[kaijiangModel alloc] init];
        _kaiJiangQiHao.lotteryDay = @"075";
        _kaiJiangQiHao.lotteryNum = @"987";
        [_kaijiangArray addObject:_kaiJiangQiHao];
        [_kaiJiangQiHao release];
    }
    [_kaiJiangTableView reloadData];
    isRefresh = NO;
    [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_PLFiveTableView];
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
