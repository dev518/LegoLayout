//
//  UIView+util.m
//  LegoDemo
//
//  Created by wudi on 2020/5/21.
//  Copyright © 2020 wudi. All rights reserved.
//

#import "UIView+util.h"
#import <objc/runtime.h>


@implementation UIView (util)

- (void)layoutSubviews{
    if (self.needSelfCaculate) {
        [self caculateAllViews];
    }
    
}


- (NSInteger)caTag{
    return [objc_getAssociatedObject(self, _cmd) integerValue];

}
- (void)setCaTag:(NSInteger)caTag{
    objc_setAssociatedObject(self, @selector(caTag), [NSNumber numberWithInteger:caTag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}


- (BOOL)needSelfCaculate{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNeedSelfCaculate:(BOOL)needSelfCaculate{
    objc_setAssociatedObject(self, @selector(needSelfCaculate), [NSNumber numberWithBool:needSelfCaculate], OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSMutableDictionary *)viewDicts
{
    NSMutableDictionary *muDic = objc_getAssociatedObject(self, _cmd);
    if (!muDic) {
        muDic = [NSMutableDictionary new];
        [self setViewDicts:muDic];
    }
    return muDic;
}

- (void)setViewDicts:(NSMutableDictionary *)viewDicts
{
    objc_setAssociatedObject(self, @selector(viewDicts), viewDicts, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)registerView:(UIView *)view  withTag:(NSInteger)tag{
    NSMutableArray *arr = [self.viewDicts objectForKey:@(tag)];
    if (arr) {
        if ([arr containsObject:view]) {
            return;
        }
        [arr addObject:view];
        [self.viewDicts setObject:arr forKey:@(tag)];
    }else{
        arr = [NSMutableArray new];
        [arr addObject:view];
        [self.viewDicts setObject:arr forKey:@(tag)];
    }
}


- (void)caculateAllViews{
    
    NSLog(@"aaaaaaaaaaaaaa");
    for (UIView *v in self.subviews) {
        if (v.caTag > 0) {
            [self registerView:v withTag:v.caTag];
        }
    }
    NSArray *allkeys = self.viewDicts.allKeys;
    for (int i = 0; i < allkeys.count; i++) {
        for (int j = i + 1 ; j < allkeys.count; j++) {
            NSInteger tag1 = [allkeys[i] integerValue];
            NSInteger tag2 = [allkeys[j] integerValue];
            NSArray *views1 = self.viewDicts[allkeys[i]];
            NSArray *views2 = self.viewDicts[allkeys[j]];
            for (UIView *v1 in views1) {
                for (UIView *v2 in views2) {
                    CGRect rect =  CGRectIntersection(v1.frame, v2.frame);
                    if (!CGRectIsEmpty(rect)) {
                        id<UIViewLayoutProtocol>tempView = nil;
                        tempView = (id<UIViewLayoutProtocol>)(tag1 > tag2 ?v2:v1);
                        UIView *highV = tag1 > tag2 ?v1:v2;
                        if ([tempView respondsToSelector:@selector(insectView:isSame:)]) {
                            [tempView insectView:highV isSame:NO];
                        }
                    }
                }
            }
        }
    }
    
    
    
    for (NSValue *key in self.viewDicts) {
        NSArray *views = self.viewDicts[key];
        for (int i = 0 ; i < views.count; i++) {
            for (int j = i + 1; j < views.count; j++) {
                UIView *v1 = views[i];
                UIView *v2 = views[j];
                CGRect rect =  CGRectIntersection(v1.frame, v2.frame);
                if (!CGRectIsEmpty(rect)) {
                    id<UIViewLayoutProtocol>tempView = CGRectGetMinY(v1.frame)< CGRectGetMinY(v2.frame) ? (id<UIViewLayoutProtocol>)v2 : (id<UIViewLayoutProtocol>)v1;
                    UIView *insectView = (UIView *)tempView == v1 ? v2 : v1;
                    if ([tempView respondsToSelector:@selector(insectView:isSame:)]) {
                        [tempView insectView:insectView isSame:YES];
                    }
                }
            }
        }
    }
}


- (CGPoint)topCenter{
    return CGPointMake(self.center.x, CGRectGetMinY(self.frame));;
}

- (CGPoint)topLeft{
    return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
}


- (CGPoint)bottomLeft{
    return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame));
}

- (CGPoint)topRight{
    return CGPointMake(self.center.x, CGRectGetMinY(self.frame));;
}

- (CGPoint)bottomRight{
    return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
}


- (CGPoint)bottomCenter{
    return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame));
}
@end
