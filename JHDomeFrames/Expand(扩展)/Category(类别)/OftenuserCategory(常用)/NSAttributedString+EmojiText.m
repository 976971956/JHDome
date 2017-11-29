//
//  NSAttributedString+EmojiText.m
//  TuiJI
//
//  Created by ddapp on 17/4/17.
//  Copyright © 2017年 LJH. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "NSAttributedString+EmojiText.h"
#import "EmojiTextAttachment.h"
#import "HWTextPart.h"
#import "RegexKitLite.h"
@implementation NSAttributedString (EmojiText)
-(NSString *)getPlainString {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if (value && [value isKindOfClass:[EmojiTextAttachment class]]) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:((EmojiTextAttachment *) value).emojiTag];
                          base += ((EmojiTextAttachment *) value).emojiTag.length - 1;
                      }
                  }];
    
    return plainString;
}
/**
 *  普通文字 --> 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
+ (NSAttributedString *)attributedTextWithText:(NSString *)text{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    //    // @的规则
    //    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    //    // #话题#的规则
    //    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    //    // url链接的规则
    //    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@", emotionPattern];
    
    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        HWTextPart *part = [[HWTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        HWTextPart *part = [[HWTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 排序
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(HWTextPart *part1, HWTextPart *part2) {
        // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        // 返回NSOrderedSame:两个一样大
        // NSOrderedAscending(升序):part2>part1
        // NSOrderedDescending(降序):part1>part2
        if (part1.range.location > part2.range.location) {
            // part1>part2
            // part1放后面, part2放前面
            return NSOrderedDescending;
        }
        // part1<part2
        // part1放前面, part2放后面
        return NSOrderedAscending;
    }];
    
    // 按顺序拼接每一段文字
    NSMutableArray *emojiTags =[NSMutableArray array];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
    NSArray *array =  [NSArray arrayWithContentsOfFile:plistPath];
    UIFont *font = [UIFont fontWithName:@"STXihei" size:16];
    NSMutableArray *mutarr = [NSMutableArray array];
    for (HWTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            NSString *name;

            for (NSDictionary *dict in array) {
                for (NSString *obj in dict) {
                    NSDictionary *myDict =@{@"mykey":dict[obj],@"name":obj};
                    [emojiTags addObject:myDict];
                    if ([part.text isEqualToString:obj]) {
                        name = dict[obj];
                    }
                }
            }

            if (name) { // 能找到对应的图片
                
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight-5, font.lineHeight-5);

                substr = [NSAttributedString attributedStringWithAttachment:attch];
                [substr drawAtPoint:CGPointMake(0, 0)];
                if (mutarr.count>0) {
                    attch.bounds = CGRectMake(0, -10, font.lineHeight-5, font.lineHeight-5);
                }
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.special) { // 非表情的特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName : [UIColor redColor]
                                                                                       }];
            
        } else { // 非特殊文字

            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attributedText appendAttributedString:substr];
    }
    
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];

    return attributedText;

}
+ (NSAttributedString *)attributedTextWithText:(NSString *)text textColor:(UIColor *)color andtextsize:(CGFloat)textsize
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];

    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    //    // @的规则
    //    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    //    // #话题#的规则
    //    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    //    // url链接的规则
    //    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@", emotionPattern];
    
    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        HWTextPart *part = [[HWTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        HWTextPart *part = [[HWTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 排序
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(HWTextPart *part1, HWTextPart *part2) {
        // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        // 返回NSOrderedSame:两个一样大
        // NSOrderedAscending(升序):part2>part1
        // NSOrderedDescending(降序):part1>part2
        if (part1.range.location > part2.range.location) {
            // part1>part2
            // part1放后面, part2放前面
            return NSOrderedDescending;
        }
        // part1<part2
        // part1放前面, part2放后面
        return NSOrderedAscending;
    }];
    
    UIFont *font = [UIFont fontWithName:@"STXihei" size:textsize];
    // 按顺序拼接每一段文字
    NSMutableArray *emojiTags =[NSMutableArray array];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
    NSArray *array =  [NSArray arrayWithContentsOfFile:plistPath];
    
    for (HWTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
//            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
     
            NSDictionary *emojidict;
            EmojiTextAttachment *emojiTextAttachment = [EmojiTextAttachment new];
            
            //Set emoji size
            emojiTextAttachment.emojiSize = EMOJIFONT;

            for (int i=0; i<array.count; i++) {
                NSDictionary *dict = array[i];
                for (NSString *obj in dict) {
                    NSDictionary *myDict =@{@"mykey":dict[obj],@"name":obj};
                    [emojiTags addObject:myDict];
                    if ([part.text isEqualToString:obj]) {
                        emojidict = myDict;
                    }
                }

            }

            
            if (emojidict) { // 能找到对应的图片
                //Set tag and image
                emojiTextAttachment.emojiTag = emojidict[@"name"];
                emojiTextAttachment.image = [UIImage imageNamed:emojidict[@"mykey"]];
                

//                attch.image = [UIImage imageNamed:name];
//                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:emojiTextAttachment];
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.special) { // 非表情的特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName : [UIColor redColor]
                                                                                       }];
            
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attributedText appendAttributedString:substr];
    }
    
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
//    [attributedText addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedText.length)];

    return attributedText;
}
+(CGRect)getString:(NSString *)str fontsize:(CGFloat)size andweight:(CGFloat)weight
{
    if (str) {
    
    }else{
        str = @"";
        return CGRectMake(0, 0, 0, 0);
    }
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    NSString *pattern = [NSString stringWithFormat:@"%@", emotionPattern];
    NSMutableString *parts = [NSMutableString stringWithString:str];
    NSMutableString *newstr = [NSMutableString string];
    [str enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        [parts deleteCharactersInRange:NSMakeRange(parts.length-3, 2)];
        [newstr appendString:@"湖"];
    }];
    // 遍历所有的非特殊字符
    [str enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        HWTextPart *part = [[HWTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [newstr appendString:*capturedStrings];
    }];

    CGRect rect = [parts getwieght:weight fontsize:size];

    return rect;
}
+(CGRect)getemjirect:(NSString *)str fontsize:(CGFloat)size andweight:(CGFloat)weight
{
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    //    // @的规则
    //    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    //    // #话题#的规则
    //    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    //    // url链接的规则
    //    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSMutableArray *parts = [NSMutableArray array];
    NSString *pattern = [NSString stringWithFormat:@"%@", emotionPattern];
    NSMutableString *partStr = [NSMutableString stringWithString:str];


    // 遍历所有的特殊字符串
    [str enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
//                HWTextPart *part = [[HWTextPart alloc] init];
//                part.special = YES;
//                part.text = *capturedStrings;
//                part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
//                part.range = *capturedRanges;
//                [parts addObject:part];
//        [partStr replaceCharactersInRange:*capturedRanges withString:@"湖"];
    }];
    // 遍历所有的非特殊字符
    [str enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        //        HWTextPart *part = [[HWTextPart alloc] init];
        //        part.text = *capturedStrings;
        //        part.range = *capturedRanges;
        //        [parts addObject:part];
        //        [partStr appendString:*capturedStrings];
    }];

    CGRect rect = [partStr getwieght:weight fontsize:size];
    
    return rect;
}
+ (CGSize)sizeLabelToFit:(NSAttributedString *)aString width:(CGFloat)width height:(CGFloat)height {
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    tempLabel.attributedText = aString;
    tempLabel.numberOfLines = 0;
    [tempLabel sizeToFit];
    CGSize size = tempLabel.frame.size;
    size = CGSizeMake([self CGFloat_ceil:size.width], [self CGFloat_ceil:size.height]);
    return size;
}
+ (CGFloat)CGFloat_ceil:(CGFloat)f {
    int a = f;
    CGFloat b = a;
    return b;
}
@end
