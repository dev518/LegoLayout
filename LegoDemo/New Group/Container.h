//
//  Container.h
//  LegoDemo
//
//  Created by wudi on 2020/5/20.
//  Copyright © 2020 wudi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ContainerLayoutProtocol <NSObject>

- (void)insectView:(UIView *)view  isSame:(BOOL)isSame;

@end

@interface Container : UIView

- (void)registerView:(UIView *)view  withTag:(NSInteger)tag;

- (void)caculateAllViews;



@end

NS_ASSUME_NONNULL_END
