//
//  kaiJiangCell.m
//  caipiaotest
//
//  Created by yuanda on 13-4-1.
//  Copyright (c) 2013年 wangjunjun. All rights reserved.
//

#import "kaiJiangCell.h"

@implementation kaiJiangCell
@synthesize kaijiangQi;
@synthesize kaijiangNum;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        kaijiangQi = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, 24)];
        kaijiangQi.text = @"073";
        kaijiangQi.font = [UIFont systemFontOfSize:14];
        kaijiangQi.backgroundColor = [UIColor clearColor];
        kaijiangQi.textColor = [UIColor blackColor];
        
        UILabel * _wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 44, 24)];
        _wordLabel.text = @"期开奖";
        _wordLabel.font = [UIFont systemFontOfSize:14];
        _wordLabel.backgroundColor = [UIColor clearColor];
        _wordLabel.textColor = [UIColor blackColor];
        
        kaijiangNum = [[UILabel alloc] initWithFrame:CGRectMake(84, 0, 60, 24)];
        kaijiangNum.text = @"073";
        kaijiangNum.font = [UIFont systemFontOfSize:14];
        kaijiangNum.backgroundColor = [UIColor clearColor];
        kaijiangNum.textColor = [UIColor colorWithRed:160.0/255.0 green:14.0/255.0 blue:54.0/255.0 alpha:1];
        
        [self.contentView addSubview:kaijiangQi];
        [self.contentView addSubview:_wordLabel];
        [self.contentView addSubview:kaijiangNum];
        [kaijiangQi release];
        [_wordLabel release];
        [kaijiangNum release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
