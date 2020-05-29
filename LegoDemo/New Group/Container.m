//
//  Container.m
//  LegoDemo
//
//  Created by wudi on 2020/5/20.
//  Copyright © 2020 wudi. All rights reserved.
//

#import "Container.h"
#import "UIView+util.h"

@interface Container ()

@property(nonatomic, strong) NSMutableArray *views;
@property(nonatomic, strong) NSMutableDictionary *viewDicts;
@property(nonatomic, strong) NSMutableArray *leftBorderPoints;
@property(nonatomic, strong) NSMutableArray *rightBorderPoints;

@end

@implementation Container
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftBorderPoints = [NSMutableArray new];
        self.views = [NSMutableArray new];
        self.viewDicts = [NSMutableDictionary new];
        self.rightBorderPoints = [NSMutableArray new];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//- (void)drawRect:(CGRect)rect{
//    NSMutableArray *borderPts = [NSMutableArray arrayWithArray:self.leftBorderPoints];
//    [borderPts addObjectsFromArray:self.rightBorderPoints];
//
//    [self drawLine:borderPts];
//}


- (void)registerView:(UIView *)view  withTag:(NSInteger)tag{
    NSMutableArray *arr = [self.viewDicts objectForKey:@(tag)];
    if (arr) {
        [arr addObject:view];
        [self.viewDicts setObject:arr forKey:@(tag)];
    }else{
        arr = [NSMutableArray new];
        [arr addObject:view];
        [self.viewDicts setObject:arr forKey:@(tag)];
    }
}


- (void)caculateAllViews{

    NSLog(@"wwwwwwwwwwwwww");
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
                        id<ContainerLayoutProtocol>tempView = nil;
                        tempView = tag1 > tag2 ?v2:v1;
                        UIView *highV = tag1 > tag2 ?v1:v2;

//                        CGRect frame = [highV.superview convertRect:rect toView:highV];
//                        UIView *v = [[UIView alloc] initWithFrame:frame];
//                        v.backgroundColor = [UIColor redColor];
//                        [v2 addSubview:v];
                        
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
                    id<ContainerLayoutProtocol>tempView = v2;
                    if ([tempView respondsToSelector:@selector(insectView:isSame:)]) {
                        [tempView insectView:v1 isSame:YES];
                    }
                }
            }
        }
    }

//    for (UIView *view in self.views) {
//
//
//        [self.leftBorderPoints addObject:[NSValue valueWithCGPoint:view.topCenter]];
//        [self.leftBorderPoints addObject:[NSValue valueWithCGPoint:view.topLeft]];
//        [self.leftBorderPoints addObject:[NSValue valueWithCGPoint:view.bottomLeft]];
//        [self.leftBorderPoints addObject:[NSValue valueWithCGPoint:view.bottomCenter]];
//
//        [self.rightBorderPoints insertObject:[NSValue valueWithCGPoint:view.topCenter] atIndex:0];
//        [self.rightBorderPoints insertObject:[NSValue valueWithCGPoint:view.topRight] atIndex:0];
//        [self.rightBorderPoints insertObject:[NSValue valueWithCGPoint:view.bottomRight] atIndex:0];
//        [self.rightBorderPoints insertObject:[NSValue valueWithCGPoint:view.bottomCenter] atIndex:0];
//
//    }
}


- (void)drawLine:(NSArray *)line {
    //判断是否有线
    if (line.count>0) {
        //获取当前上下文对象
        CGContextRef context = UIGraphicsGetCurrentContext();
        //通道开始
        CGContextBeginPath(context);
        //遍历线数组
        NSInteger index = 0;
        for (NSValue *value in line) {
            CGPoint pt = [value CGPointValue];
            if (index == 0) {
                CGContextMoveToPoint(context, pt.x, pt.y);
                index++;
            }else{
                CGContextAddLineToPoint(context, pt.x, pt.y);
            }
        }
        //画线
        CGContextStrokePath(context);
    }
}





@end
