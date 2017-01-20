//
//  LTHeadView.h
//  QuYou_iOS
//
//  Created by LPPZ-User01 on 2016/11/7.
//  Copyright © 2016年 LongTengTechnologyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTHeadView : UIView

/*
 *brief 添加横条  当controlls 数量偏少时候 滚动条不会滑动,反之会有向中心偏移的动画
 *
 *controllers  数据源包含VC 和标题
 *
 *underline   是佛显示下路线
 */
- (void)controllers:(NSArray<UIViewController *> *)controllers showUnderline:(BOOL)showUnderline;


@end
