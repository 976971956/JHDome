//
//  NSAttributedString+EmojiText.h
//  TuiJI
//
//  Created by ddapp on 17/4/17.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (EmojiText)
-(NSString *)getPlainString;
//获取表情文字
+ (NSAttributedString *)attributedTextWithText:(NSString *)text;

+ (NSAttributedString *)attributedTextWithText:(NSString *)text textColor:(UIColor *)color andtextsize:(CGFloat)textsize;
/**
 获取表情文字的宽高

 @param str 表情文字
 @param size 文字大小
 @param weight 宽度
 @return 位置宽高
 */
+(CGRect)getString:(NSString *)str fontsize:(CGFloat)size andweight:(CGFloat)weight;
+(CGRect)getemjirect:(NSString *)str fontsize:(CGFloat)size andweight:(CGFloat)weight;

+ (CGSize)sizeLabelToFit:(NSAttributedString *)aString width:(CGFloat)width height:(CGFloat)height;
@end
