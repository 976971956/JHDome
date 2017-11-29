//
//  NSString+Emoji.h
//  黑马微博
//
//  Created by MJ Lee on 14/7/12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
- (NSString *)emoji;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;
//中文转拼音
-(NSString *)transform:(NSString *)chinese;
//判断是否字母开头
-(BOOL)MatchLetter:(NSString *)str;
//判断是否数字开头
-(BOOL)NumLetter:(NSString *)str;
//判断是否中文开头
-(BOOL)isChineseFirst:(NSString *)firstStr;
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)aString;
//获取文字宽高
-(CGRect)getwieght:(CGFloat)weight fontsize:(CGFloat)size;
-(CGFloat)getheight:(NSString *)texts font:(CGFloat)fontsize;
- (NSString *)set_md5;
@end
