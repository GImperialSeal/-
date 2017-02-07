//
//  ViewController.m
//  coolNavi
//
//  Created by 顾玉玺 on 2017/1/16.
//  Copyright © 2017年 顾玉玺. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TableViewCell.h"
#import "TableLinkage.h"
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end


@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"id"];
    
    
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
    
    TableLinkage *headView = [[TableLinkage alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:TableLinkageStyleHeadView];
    [headView controllers:@[vc1,vc2,vc3,vc4,vc5,vc6]showUnderline:NO] ;
    [self.view addSubview:headView];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"id" configuration:^(id cell) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
    return cell;
}


@end
