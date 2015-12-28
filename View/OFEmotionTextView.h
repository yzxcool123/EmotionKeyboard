//
//  OFEmotionTextView.h
//  OnFire
//
//  Created by YeZhongxiang on 15/12/23.
//  Copyright © 2015年 OnFire. All rights reserved.
//

#import "OFTextView.h"

@class OFEmotion;
@interface OFEmotionTextView : OFTextView

/** 拼接表情到最后面 */
- (void)appendEmotion:(OFEmotion *)emotion;

/** 具体的文字内容 */
- (NSString *)realText;

@end
