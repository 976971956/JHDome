//
//  UIControl+JHButtonSel.m
//  TuiJI
//
//  Created by ddapp on 17/5/17.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "UIControl+JHButtonSel.h"
#import <objc/runtime.h>

@implementation UIControl (JHButtonSel)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

static const char *UIcontrol_ignoreEvent = "UIcontrol_ignoreEvent";

- (NSTimeInterval)LJH_acceptEventInterval {
    
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
    
}

- (void)setLJH_acceptEventInterval:(NSTimeInterval)LJH_acceptEventInterval {
    
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(LJH_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (BOOL)noClick {
    
    return [objc_getAssociatedObject(self, UIcontrol_ignoreEvent) boolValue];
    
}

- (void)setNoClick:(BOOL)noClick {
    
    objc_setAssociatedObject(self, UIcontrol_ignoreEvent, @(noClick), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

+ (void)load {
    
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    
    Method b = class_getInstanceMethod(self, @selector(ljh_sendAction:to:forEvent:));
    
    method_exchangeImplementations(a, b);
    
}

- (void)ljh_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (self.noClick) return;
    
    if (self.LJH_acceptEventInterval > 0) {
        
        self.noClick = YES;
        
        [self performSelector:@selector(setNoClick:) withObject:@(NO) afterDelay:self.LJH_acceptEventInterval];
        
    }
    
    [self ljh_sendAction:action to:target forEvent:event];
    
}



@end
