//
//  ViewController.m
//  coolNavi
//
//  Created by 顾玉玺 on 2017/1/16.
//  Copyright © 2017年 顾玉玺. All rights reserved.
//

#import "ViewController.h"
#import "LTHeadView.h"
#define  topViewHeight  170
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

@interface ViewController (){
   LTHeadView *_headView;
}

@end


@implementation ViewController

//- (void)loadView{
//    [super loadView];
//    CGFloat width = [[UIScreen mainScreen]bounds].size.width;
//    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
//    
//    // content scorllview
//    UIScrollView *scorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topViewHeight, width, height)];
//    scorllView.contentSize = CGSizeMake(width, height-64);
//    scorllView.backgroundColor = [UIColor orangeColor];
//    scorllView.bounces = NO;
//    scorllView.directionalLockEnabled = YES;
//    scorllView.showsVerticalScrollIndicator = NO;
//    
//    self.view = [[GFCoolNaviView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   // [self headView];
    
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.title = @"头条";
    vc1.view.backgroundColor = [UIColor grayColor];
    
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.title = @"热点";
    vc2.view.backgroundColor = [UIColor grayColor];
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.title = @"视频";
    vc3.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.title = @"社会";
    vc4.view.backgroundColor = [UIColor grayColor];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    vc5.title = @"订阅";
    vc5.view.backgroundColor = [UIColor yellowColor];
    UIViewController *vc6 = [[UIViewController alloc] init];
    vc6.view.backgroundColor = [UIColor orangeColor];
    vc6.title = @"科技";
    
    LTHeadView *headView = [[LTHeadView alloc] initWithFrame:self.view.bounds];
    [headView controllers:@[vc1,vc2,vc3,vc4,vc5,vc6]showUnderline:NO] ;
    [self.view addSubview:headView];
    
}

- (void)headView{
    
    CGFloat width = [[UIScreen mainScreen]bounds].size.width;
  //  CGFloat height = [[UIScreen mainScreen]bounds].size.height;

    // 背景图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    imageView.tag = 101;
    imageView.frame = CGRectMake(0, -64, width, topViewHeight+64);
    
    // 签名
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(120, 100, 300, 80);
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.text = @"妹子!\n个性签名,啦啦啦!";
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 102;
   // [self.view addSubview:label];
    
    UIScrollView *scorll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [scorll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

    scorll.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:scorll];
    [scorll addSubview:imageView];
    

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGPoint point = [change[@"new"] CGPointValue];
    
    NSLog(@"%f",point.y);
    UIScrollView *scorllView = object;
    CGFloat scale = point.y/(topViewHeight-64);
    
    scorllView.transform = CGAffineTransformMakeTranslation(0, -point.y);
    
    // 背景图
    UIImageView *imageView = [self.view viewWithTag:101];
    imageView.transform = CGAffineTransformMakeTranslation(0, point.y);
    
    // 签名
    UILabel *label = [self.view viewWithTag:102];
    label.transform = CGAffineTransformMakeTranslation(0, -point.y);
    label.alpha = 1-scale;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
