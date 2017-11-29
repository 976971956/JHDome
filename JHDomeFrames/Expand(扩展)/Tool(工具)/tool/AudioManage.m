//
//  AudioManage.m
//  TuiJI
//
//  Created by ddapp on 17/4/22.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "AudioManage.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioManage()
{
    //初始化一个录音控制器
    
    AVAudioRecorder * recorder;
    
    AVAudioSession* audioSession;
    
    int number;
    
    NSURL * urlPlay;
    

}
@end

@implementation AudioManage
- (void)audio{
    
    audioSession= [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    [audioSession setActive:YES error:nil];
    
    //录音设置
    
    NSMutableDictionary*recordSetting = [[NSMutableDictionary alloc]init];
    
    //设置录音格式
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    
    //设置录音采样率(Hz)如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    
    [recordSetting setValue:[NSNumber numberWithFloat:44100]forKey:AVSampleRateKey];
    
    //录音通道数1或2
    
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    
    //线性采样位数8、16、24、32
    
    [recordSetting setValue:[NSNumber numberWithInt:16]forKey:AVLinearPCMBitDepthKey];
    
    //录音的质量
    
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh]forKey:AVEncoderAudioQualityKey];
    
    NSString*strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)lastObject];
    
    urlPlay= [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%d.aac", strUrl,number++]];
    
    NSError*error;
    
    //初始化
    
    recorder= [[AVAudioRecorder alloc]initWithURL:urlPlay settings:recordSetting error:&error];
    
    //开启音量检测
    
    recorder.meteringEnabled=YES;
    
}


@end
