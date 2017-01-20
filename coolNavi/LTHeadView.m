//
//  LTHeadView.m
//  QuYou_iOS
//
//  Created by LPPZ-User01 on 2016/11/7.
//  Copyright © 2016年 LongTengTechnologyCompany. All rights reserved.
//

#import "LTHeadView.h"

// 横条高度
#define headHeight 44

// 自定义导航的高度
#define naviagtionHeight 64

// 顶部背景图的高度
#define  topViewHeight  170

@interface LTHeadView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *topTitleScorllView;
// 选中按钮
@property (nonatomic, weak) UIButton *selTitleButton;

@property (nonatomic,strong) UIScrollView *contentScorllView;


@end
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

#define SP_SCREEN [UIScreen mainScreen].bounds.size.width/375

@implementation LTHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 背景 scorll(最里面的scorll)
        UIScrollView *scorll = [[UIScrollView alloc]initWithFrame:frame];
        scorll.contentSize = CGSizeMake(0, SCREEN_HEIGHT+topViewHeight-naviagtionHeight);
        scorll.bounces = NO;
        scorll.directionalLockEnabled = YES;
        [scorll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self addSubview:scorll];
        
        // 最上面部分
        [self topHeadViewWith:scorll];
        
        // 横条
        UIScrollView *topTitleScorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topViewHeight, frame.size.width, headHeight)];
        topTitleScorllView.backgroundColor = [UIColor orangeColor];
        [scorll addSubview:topTitleScorllView];
        
        
        
        // 内容
        UIScrollView *contentScorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topTitleScorllView.frame), frame.size.width, frame.size.height-headHeight)];
        contentScorllView.pagingEnabled = YES;
        contentScorllView.delegate = self;
        contentScorllView.backgroundColor = [UIColor yellowColor];
        contentScorllView.showsHorizontalScrollIndicator = NO;
        [scorll addSubview:contentScorllView];
        self.topTitleScorllView = topTitleScorllView;
        self.contentScorllView = contentScorllView;
        
    }
    return self;
}

- (void)controllers:(NSArray *)controllers showUnderline:(BOOL)showUnderline{
    
    // buttons  之间的间隙
    CGFloat buttonsGap = 60.0;
    
    // top scroll 的容量
    CGFloat titleScrollViewContentSizeOfWidth = 20.0;
    
    for (int i = 0; i<controllers.count; i++) {
        // 添加内容
        UIViewController *VC = [controllers objectAtIndex:i];
        VC.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScorllView.frame));
       
        [self.contentScorllView addSubview:VC.view];
        
        // 下划线
        UILabel *underlineLabel = [[UILabel alloc]init];
        underlineLabel.backgroundColor = [UIColor grayColor];
        underlineLabel.hidden = showUnderline;
        underlineLabel.tag = 303;
        [self.topTitleScorllView addSubview:underlineLabel];
        
        // 添加横条
        UIButton *button = [[UIButton alloc]init];
        button.tag = i+100;
        [button setTitle:VC.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickTopViewButton:) forControlEvents:UIControlEventTouchUpInside];
        
        // 自适应大小
        CGSize buttonRealSize = [button sizeThatFits:CGSizeMake(200, 100)];
        
        if (40+(controllers.count-1)*(buttonRealSize.width+buttonsGap)+buttonRealSize.width<=SCREEN_WIDTH) {
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.frame = CGRectMake(i*SCREEN_WIDTH/controllers.count, (headHeight-buttonRealSize.height)/2, SCREEN_WIDTH/controllers.count, buttonRealSize.height);
            if (i == controllers.count-1) {
                titleScrollViewContentSizeOfWidth = SCREEN_WIDTH;
            }
        }else{
             button.frame = CGRectMake(20+i%controllers.count*(buttonRealSize.width+buttonsGap), (headHeight-buttonRealSize.height)/2, buttonRealSize.width, buttonRealSize.height);
            if (i == controllers.count-1) {
                // 20 最后一个button 与屏幕边缘的间距
                titleScrollViewContentSizeOfWidth = CGRectGetMaxX(button.frame)+20;
            }
        }
        
        [self.topTitleScorllView addSubview:button];

        
        
        
        if (i == 0) {
            [self selectedTitleBtn:button];
        }
    }
    
    
    self.topTitleScorllView.contentSize = CGSizeMake(titleScrollViewContentSizeOfWidth, 0);
    self.contentScorllView.contentSize = CGSizeMake(controllers.count*SCREEN_WIDTH, 600);
}

- (void)clickTopViewButton:(UIButton *)btn{
    self.contentScorllView.contentOffset = CGPointMake(SCREEN_WIDTH*(btn.tag-100), 0);
    [self selectedTitleBtn:btn];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger i = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self selectedTitleBtn:[self.topTitleScorllView viewWithTag:i+100]];
}

// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger leftIndex = offsetX / SCREEN_WIDTH;
    NSInteger rightIndex = leftIndex + 1;
    
    UIButton *leftButton = [self.topTitleScorllView viewWithTag:leftIndex+100];
    
    UIButton *rightButton = nil;
    if (rightIndex < self.contentScorllView.contentSize.width/SCREEN_WIDTH) {
        
        rightButton = [self.topTitleScorllView viewWithTag:leftIndex+100];

    }
    
    CGFloat scaleR = offsetX / SCREEN_WIDTH - leftIndex;
    
    CGFloat scaleL = 1 - scaleR;
    
    CGFloat transScale = 0.3;
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];

}


//  设置title 向中心偏移
- (void)setupTitleCenter:(UIButton *)btn{
    CGFloat offset = btn.center.x - SCREEN_WIDTH * 0.5;
    
    if (offset < 0){
        offset = 0;
    }
    
    CGFloat maxOffset = self.topTitleScorllView.contentSize.width - SCREEN_WIDTH;
    if (offset > maxOffset){
        offset = maxOffset;
    }
    
    [self.topTitleScorllView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}

// 选中按钮
- (void)selectedTitleBtn:(UIButton *)btn{
    [self.selTitleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selTitleButton.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.selTitleButton = btn;
    [self setupTitleCenter:btn];
    
    
    UILabel *underlineLabel = [self.topTitleScorllView viewWithTag:303];
    [UIView animateWithDuration:0.3 animations:^{
        underlineLabel.frame = CGRectMake(CGRectGetMinX(btn.frame), headHeight-6,CGRectGetWidth(btn.frame), 3);

    }];

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGPoint point = [change[@"new"] CGPointValue];
    
    NSLog(@"%f",point.y);
    UIScrollView *scorllView = object;
    CGFloat scale = point.y/(topViewHeight-naviagtionHeight);
    
    
    // 背景图
    UIImageView *imageView = [scorllView viewWithTag:1001];
    
    imageView.transform = CGAffineTransformMakeTranslation(0,topViewHeight*scale);
    
    // 签名
//    UILabel *label = [self viewWithTag:102];
//    label.transform = CGAffineTransformMakeTranslation(0, -point.y);
//    label.alpha = 1-scale;
    
}




#pragma mark - UI部分

// 最上面的背景图片
- (void)topHeadViewWith:(UIScrollView *)scorll{
    // 背景图片
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
//    imageView.tag = 1001;
//    imageView.frame = CGRectMake(0, -naviagtionHeight, SCREEN_WIDTH, topViewHeight+naviagtionHeight);
//    
//    // 签名
//    UILabel *label = [[UILabel alloc]init];
//    label.frame = CGRectMake(21, 100, 300, 80);
//    label.numberOfLines = 2;
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"妹子!\n个性签名,啦啦啦!";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.tag = 102;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topViewHeight+naviagtionHeight)];
    view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    imageView.frame = CGRectMake(30, 30, 80, 80);
    
    [view addSubview:imageView];
    
    [scorll addSubview:view];
}

- (UIScrollView *)topTitleScorllView{
    if (_topTitleScorllView) return _topTitleScorllView;
    return _topTitleScorllView;
    
}

- (UIScrollView *)contentScorllView{
    if (_contentScorllView) return _contentScorllView;
    return _contentScorllView;
}

@end
