//
//  ViewController.m
//  RNTest2
//
//  Created by 汪淼 on 2017/11/16.
//  Copyright © 2017年 汪淼. All rights reserved.
//

#import "ViewController.h"
#import <React/RCTRootView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString * strUrl = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
    NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];
    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"ModuleA" initialProperties:nil launchOptions:nil];
    [self.view addSubview:rootView];
    rootView.frame = CGRectMake(0, 20, 300, 300);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
