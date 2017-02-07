//
//  TableViewCell.m
//  coolNavi
//
//  Created by 顾玉玺 on 2017/1/20.
//  Copyright © 2017年 顾玉玺. All rights reserved.
//

#import "TableViewCell.h"
#import "PureLayout.h"

@interface TableViewCell ()

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subtitleLabel;
@property (nonatomic,strong) UILabel *dateLabel;

@property (nonatomic,strong) UIImageView *vipImageView;
@property (nonatomic,strong) UIImageView *notificationHub;
@end

@implementation TableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor orangeColor];
        
        //[self leftImage_titleLabel];
        [self chatGroupStyle];
        
        self.showVipImageView = YES;
        self.showNotificationHub = YES;
        
    }
    return self;
}


- (void)leftImage_titleLabel{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123.jpg"]];
    [self.contentView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"12333";
    [self.contentView addSubview:titleLabel];
    
    
    UIEdgeInsets set = UIEdgeInsetsMake(12, 12, 12, 0);
    [imageView autoPinEdgesToSuperviewEdgesWithInsets:set excludingEdge:ALEdgeRight];
    [imageView autoSetDimensionsToSize:CGSizeMake(80, 80)];
    
    [titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imageView withOffset:12];
    [titleLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
}


- (void)chatGroupStyle{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123.jpg"]];
    [self.contentView addSubview:imageView];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    [self.contentView addSubview:lineLabel];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.text = @"12333";
    [self.contentView addSubview:titleLabel];
    
    UILabel *subtitleLabel = [[UILabel alloc]init];
    subtitleLabel.text = @"12wefwefawfwafwefwaefwfwefwefwaefwaefwaef12";
    subtitleLabel.font = [UIFont systemFontOfSize:14];
    subtitleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:subtitleLabel];
    
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.text = @"昨天";
    [self.contentView addSubview:dateLabel];
    
    self.titleLabel = titleLabel;
    self.leftImageView = imageView;
    self.subtitleLabel = subtitleLabel;
    self.dateLabel = dateLabel;
    
    
    UIEdgeInsets set = UIEdgeInsetsMake(12, 12, 12, 0);
    [imageView autoPinEdgesToSuperviewEdgesWithInsets:set excludingEdge:ALEdgeRight];
    [imageView autoSetDimensionsToSize:CGSizeMake(80, 80)];
    
    [lineLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [lineLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imageView];
    [lineLabel autoSetDimensionsToSize:CGSizeMake(1, 8)];
    
    [titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imageView withOffset:12];
    [titleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:lineLabel];
    
    [dateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
    [dateLabel  autoAlignAxis:ALAxisFirstBaseline toSameAxisOfView:titleLabel];
    
    [subtitleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imageView withOffset:12];
    [subtitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lineLabel];
    [subtitleLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:dateLabel withOffset:0 relation:-1];
}

#pragma mark - set Function
- (void)setShowVipImageView:(BOOL)showVipImageView{
    _showVipImageView = showVipImageView;
    
    UIImageView *vipImageView = [UIImageView newAutoLayoutView];
    vipImageView.image = [UIImage imageNamed:@"123.jpg"];
    
    [self.contentView addSubview:vipImageView];
    
    self.vipImageView = vipImageView;
    
    [vipImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.titleLabel withOffset:12];
    [vipImageView autoSetDimensionsToSize:CGSizeMake(42, 21)];
    [vipImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.titleLabel];
}

- (void)setShowNotificationHub:(BOOL)showNotificationHub{
    _showNotificationHub = showNotificationHub;
    
    UIImageView *notificationHub = [UIImageView newAutoLayoutView];
    notificationHub.image = [UIImage imageNamed:@"123.jpg"];
    
    [self.contentView addSubview:notificationHub];
    
    self.notificationHub = notificationHub;
    
    [notificationHub autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.dateLabel withOffset:8];
    [notificationHub autoSetDimensionsToSize:CGSizeMake(21, 21)];
    [notificationHub autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.dateLabel];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
