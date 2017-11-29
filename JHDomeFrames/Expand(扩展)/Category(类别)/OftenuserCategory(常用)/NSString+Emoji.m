//
//  NSString+Emoji.m
//  黑马微博
//
//  Created by MJ Lee on 14/7/12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NSString+Emoji.h"
//MD5加密类
#import <CommonCrypto/CommonDigest.h>
#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (Emoji)

+ (NSString *)emojiWithIntCode:(int)intCode {
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

- (NSString *)emoji
{
    return [NSString emojiWithStringCode:self];
}

+ (NSString *)emojiWithStringCode:(NSString *)stringCode
{
    char *charCode = (char *)stringCode.UTF8String;
    int intCode = strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:intCode];
}

// 判断是否是 emoji表情
- (BOOL)isEmoji
{
     BOOL returnValue = NO;
         
     const unichar hs = [self characterAtIndex:0];
     // surrogate pair
     if (0xd800 <= hs && hs <= 0xdbff) {
         if (self.length > 1) {
             const unichar ls = [self characterAtIndex:1];
             const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
             if (0x1d000 <= uc && uc <= 0x1f77f) {
                 returnValue = YES;
             }
         }
     } else if (self.length > 1) {
         const unichar ls = [self characterAtIndex:1];
         if (ls == 0x20e3) {
             returnValue = YES;
         }
     } else {
         // non surrogate
         if (0x2100 <= hs && hs <= 0x27ff) {
             returnValue = YES;
         } else if (0x2B05 <= hs && hs <= 0x2b07) {
             returnValue = YES;
         } else if (0x2934 <= hs && hs <= 0x2935) {
             returnValue = YES;
         } else if (0x3297 <= hs && hs <= 0x3299) {
             returnValue = YES;
         } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
             returnValue = YES;
         }
     }
    
    return returnValue;
}
//中文转拼音
-(NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

#pragma mark 正则表达式
//判断是否字母开头
-(BOOL)MatchLetter:(NSString *)str
{
    //判断是否以字母开头
    NSString *ZIMU = @"^[A-Za-z]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}
//判断是否数字开头
-(BOOL)NumLetter:(NSString *)str
{
    //判断是否以字母开头
    NSString *ZIMU = @"^[0-9]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}
//判断是否中文开头
-(BOOL)isChineseFirst:(NSString *)firstStr
{
    //是否以中文开头(unicode中文编码范围是0x4e00~0x9fa5)
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    //判断是不是中文开头的,buffer->获取字符的字节数据 maxLength->buffer的最大长度 usedLength->实际写入的长度，不需要的话可以传递NULL encoding->字符编码常数，不同编码方式转换后的字节长是不一样的，这里我用了UTF16 Little-Endian，maxLength为2字节，如果使用Unicode，则需要4字节 options->编码转换的选项，有两个值，分别是NSStringEncodingConversionAllowLossy和NSStringEncodingConversionExternalRepresentation range->获取的字符串中的字符范围,这里设置的第一个字符 remainingRange->建议获取的范围，可以传递NULL
    BOOL b = [firstStr getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        return YES;
    else
        return NO;
}
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    NSArray *array = [pinYin componentsSeparatedByString:@" "];
    NSMutableString *mutstr =[NSMutableString string];
    for (NSString *str in array) {
        [mutstr appendString:[str substringToIndex:1]];
    }
    //获取并返回首字母
    return mutstr;
}
-(CGFloat)getheight:(NSString *)texts font:(CGFloat)fontsize
{
    UITextView *textview = [[UITextView alloc]init];
    textview.attributedText = [NSAttributedString attributedTextWithText:texts textColor:nil andtextsize:fontsize];
    CGSize sizemake =  [textview sizeThatFits:CGSizeMake(SCREEN_WIDTH-60, 5000)];
    CGSize size = [textview.text sizeWithFont:[textview font]];
    int length = size.height;
    int heightCount = sizemake.height/length;
    CGFloat height;
    if (heightCount>2) {
        height = length*2;
    }else{
        height = sizemake.height;
    }
    return height;
}
-(CGRect)getwieght:(CGFloat)weight fontsize:(CGFloat)size
{
    CGRect rects =[self boundingRectWithSize:CGSizeMake(weight, 5000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    return rects;
}
- (NSString *)set_md5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
