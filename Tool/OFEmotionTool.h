//
//  OFEmotionTool.h
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OFEmotion;
@interface OFEmotionTool : NSObject

/**
 * 返回表情对象数组
 */
+ (NSArray *)defaultEmotions;

/**
 * 根据表情对应的文字描述找出对应的表情对象
 */
+ (OFEmotion *)emotionWithDesc:(NSString *)desc;

@end
