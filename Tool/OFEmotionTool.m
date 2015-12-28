//
//  OFEmotionTool.m
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//

#import "OFEmotionTool.h"
#import "OFEmotion.h"
#import "MJExtension.h"

@implementation OFEmotionTool

/** 默认表情 */
static NSArray *_defaultEmotions;

+ (NSArray *)defaultEmotions {
    
    if (_defaultEmotions == nil) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"Emotions/_emotionInfo.plist" ofType:nil];
        _defaultEmotions = [OFEmotion mj_objectArrayWithFile:plist]; // MJExtension
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"Emotions"];
    }
    return _defaultEmotions;
}

/** 根据表情描述找出对应的表情对象 */
+ (OFEmotion *)emotionWithDesc:(NSString *)desc {
    if (!desc) return nil;
    
    __block OFEmotion *foundEmotion = nil;
    
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(OFEmotion *emotion, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    if (foundEmotion) return foundEmotion;
    return nil;
}

@end
