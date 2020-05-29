//
//  vdemo.m
//  LegoDemo
//
//  Created by wudi on 2020/5/21.
//  Copyright © 2020 wudi. All rights reserved.
//

#import "vdemo.h"
#import "Container.h"
#import "UIView+util.h"

@interface vdemo ()<ContainerLayoutProtocol>

@end

@implementation vdemo

- (void)insectView:(UIView *)view  isSame:(BOOL)isSame{
    if (isSame) {
        CGRect frame = self.frame;
        frame.origin.y = CGRectGetMaxY(view.frame) + 10;
        self.frame = frame;
    }else{
        CGFloat maxwith = CGRectGetWidth(self.frame);
        CGRect frame = self.frame;
        frame.origin.x = CGRectGetMinX(self.frame);

        
        if (CGRectGetMinX(view.frame) > CGRectGetMinX(self.frame)) {
            maxwith = CGRectGetMinX(view.frame) - CGRectGetMinX(self.frame) - 10;
        }else{
            maxwith = self.superview.frame.size.width - CGRectGetMaxX(view.frame);
            frame.origin.x = CGRectGetMaxX(view.frame);
        }
        
        
        frame.size.width = MIN(maxwith, CGRectGetWidth(frame));
        if (self.needwarp) {
            frame.size.height += 30;
        }
        self.frame = frame;
    }
    

    [self setNeedsDisplay];
}

CGPoint beginPoint;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    
    beginPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint nowPoint = [touch locationInView:self];
    
    float offsetX = nowPoint.x - beginPoint.x;
    float offsetY = nowPoint.y - beginPoint.y;
 
    
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  
    
    [self setButtonPosition];
}

- (void)setButtonPosition {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyUpdate" object:nil];
//    [self setNeedsLayout];
//    [self.superview setNeedsLayout];
//    [self layoutIfNeeded];
//    [self.superview layoutIfNeeded];
    [self.superview caculateAllViews];
}
@end
