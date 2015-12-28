//
//  OFEmotion.h
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//  每一个表情的模型

#import <Foundation/Foundation.h>

@interface OFEmotion : NSObject

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的繁体文字描述 */
@property (nonatomic, copy) NSString *cht;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** 表情的存放文件夹\目录 */
@property (nonatomic, copy) NSString *directory;;

@end
