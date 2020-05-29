//
//  UIView+util.h
//  LegoDemo
//
//  Created by wudi on 2020/5/21.
//  Copyright © 2020 wudi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol UIViewLayoutProtocol <NSObject>

- (void)insectView:(UIView *)view  isSame:(BOOL)isSame;
@end

@interface UIView (util)
- (CGPoint)topCenter;

- (CGPoint)topLeft;


- (CGPoint)bottomLeft;

- (CGPoint)topRight;

- (CGPoint)bottomRight;


- (CGPoint)bottomCenter;

- (void)caculateAllViews;

- (BOOL)needSelfCaculate;
- (void)setNeedSelfCaculate:(BOOL)needSelfCaculate;


- (NSInteger)caTag;
- (void)setCaTag:(NSInteger)caTag;
@end

NS_ASSUME_NONNULL_END
