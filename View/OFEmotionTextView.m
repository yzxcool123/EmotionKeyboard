//
//  OFEmotionTextView.m
//  OnFire
//
//  Created by YeZhongxiang on 15/12/23.
//  Copyright © 2015年 OnFire. All rights reserved.
//

#import "OFEmotionTextView.h"
#import "OFEmotion.h"
#import "OFEmotionAttachment.h"

@implementation OFEmotionTextView

/** 拼接表情到最后面 */
- (void)appendEmotion:(OFEmotion *)emotion {
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    // 创建一个表情附件
    OFEmotionAttachment *attachment = [[OFEmotionAttachment alloc] init];
    attachment.emotion = emotion;
    attachment.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // 记录表情的插入位置
    NSUInteger insertIndex = self.selectedRange.location;
    
    // 插入图片表情到光标位置
    [attributedText insertAttributedString:attachString atIndex:insertIndex];
    
    // 设置字体
    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
    
    // 重新赋值
    self.attributedText = attributedText; // ->光标会回到文字最后面
    
    // 光标回到表情后面
    self.selectedRange = NSMakeRange(insertIndex + 1, 0);
}

/** 具体的文字内容 */
- (NSString *)realText {
    // 用来拼接所有的文字
    NSMutableString *string = [NSMutableString string];
    
    // 遍历富文本里面的内容
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        OFEmotionAttachment *attachment = attrs[@"NSAttachment"];
        if (attachment) { // 带有图片附件
            [string appendString:attachment.emotion.chs];
        } else { // 普通的文本
            NSString *subStr = [self.attributedText attributedSubstringFromRange:range].string;
            [string appendString:subStr];
        }
    }];
    return string;
}

@end
