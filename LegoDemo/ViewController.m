//
//  ViewController.m
//  LegoDemo
//
//  Created by wudi on 2020/5/20.
//  Copyright © 2020 wudi. All rights reserved.
//

#import "ViewController.h"
#import "Container.h"
#import "UIView+util.h"
#import "vdemo.h"
#import "cellDemo.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) vdemo *v1;
@property(nonatomic, strong) vdemo *v2;
@property(nonatomic, strong) vdemo *v3;
@property(nonatomic, strong) vdemo *v4;
@property(nonatomic, strong) vdemo *v5;
@property(nonatomic, strong) vdemo *v6;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    [self.tableView registerClass:[cellDemo class] forCellReuseIdentifier:@"demo"];
//    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyUpdate) name:@"notifyUpdate" object:nil];
    
    self.view.needSelfCaculate = YES;
    self.v1;
    self.v2;
    self.v3;
    self.v4;
    self.v5;
    self.v6;
    
    [self.view caculateAllViews];
//    [self.view addSubview: self.container];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cellDemo *cell = [tableView dequeueReusableCellWithIdentifier:@"demo"];
    [cell layout];
    return cell;
}


- (void)notifyUpdate{
    [self.tableView reloadData];
    
    
    [self.view caculateAllViews];


}


- (vdemo *)v1{
    if (!_v1) {
        vdemo *v1 = [[vdemo alloc] initWithFrame:CGRectMake(30, 20, 100, 60)];
        v1.backgroundColor = [UIColor grayColor];
        [self.view addSubview:v1];
        v1.caTag = 100;
        _v1 = v1;
    }
    return _v1;
}

- (vdemo *)v2{
    if (!_v2) {
        vdemo *v2 = [[vdemo alloc] initWithFrame:CGRectMake(10, 90, 120, 60)];
        v2.backgroundColor = [UIColor greenColor];
        v2.needwarp = YES;
        
        [self.view addSubview:v2];
        v2.caTag = 100;
        _v2 = v2;
    }
    return _v2;
}

- (vdemo *)v3{
    if (!_v3) {
        
        vdemo *v3 = [[vdemo alloc] initWithFrame:CGRectMake(50, 160, 200, 100)];
        v3.backgroundColor = [UIColor yellowColor];
        
        [self.view addSubview:v3];
        v3.caTag = 100;
        _v3 = v3;
    }
    return _v3;
}

- (vdemo *)v4{
    if (!_v4) {
        
        vdemo *v4 = [[vdemo alloc] initWithFrame:CGRectMake(150, 50, 100, 60)];
        v4.backgroundColor = [UIColor grayColor];
        [self.view addSubview:v4];
        v4.caTag = 200;
        _v4 = v4;
    }
    return _v4;
}

- (vdemo *)v5{
    if (!_v5) {
        
        vdemo *v5 = [[vdemo alloc] initWithFrame:CGRectMake(150, CGRectGetMaxY(self.v4.frame) + 10, 120, 60)];
        v5.backgroundColor = [UIColor greenColor];
        
        [self.view addSubview:v5];
        v5.caTag = 200;
        _v5 = v5;
    }
    return _v5;
}

- (vdemo *)v6{
    if (!_v6) {
        
        vdemo *v6 = [[vdemo alloc] initWithFrame:CGRectMake(280,  CGRectGetMaxY(self.v5.frame) + 10, 200, 100)];
        v6.backgroundColor = [UIColor yellowColor];
        
        [self.view addSubview:v6];
        v6.caTag = 200;
        _v6 = v6;
    }
    return _v6;
}


@end
