//
//  OFEmotionMacro.h
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//  表情键盘相关的宏

#ifndef OFEmotionMacro_h
#define OFEmotionMacro_h

// 表情选中的通知
#define OFEmotionDidSelectedNotification @"OFEmotionDidSelectedNotification"
// 点击删除按钮的通知
#define OFEmotionDidDeletedNotification @"OFEmotionDidDeletedNotification"
// 通知里面取出表情用的key
#define OFSelectedEmotion @"OFSelectedEmotion"
// 表情的最大行数
#define OFEmotionMaxRows 3
// 表情的最大列数
#define OFEmotionMaxCols 7
// 每页最多显示多少个表情
#define OFEmotionMaxCountPerPage (OFEmotionMaxRows * OFEmotionMaxCols - 1)


#endif /* OFEmotionMacro_h */
