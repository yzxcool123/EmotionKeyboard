//
//  OFEmotionListView.h
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//  展示1个或多个分页表情(GridView)

#import <UIKit/UIKit.h>

@interface OFEmotionListView : UIView

/** 需要展示的所有表情 */
@property (nonatomic, strong) NSArray *emotions;

@end
