//
//  OFEmotion.m
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//

#import "OFEmotion.h"

@implementation OFEmotion

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", self.chs, self.png];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.cht = [decoder decodeObjectForKey:@"cht"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.directory = [decoder decodeObjectForKey:@"directory"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.cht forKey:@"cht"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.directory forKey:@"directory"];
}

@end
