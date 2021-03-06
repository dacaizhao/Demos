//
//  ViewController.m
//  MultiControllerTargetTest
//
//  Created by ShenYj on 2017/1/19.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "LeftTableViewController.h"
#import "RightViewController.h"

@interface ViewController ()

@property (nonatomic) LeftTableViewController *tableViewController;
@property (nonatomic) RightViewController *viewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 监听设备朝向变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self prepareView];
    
}

- (void)deviceOrientationDidChangeNotification:(NSNotification *)notification {
    
    UIDevice *device = (UIDevice *)notification.object;
    if (UIDeviceOrientationIsPortrait(device.orientation)) {
        NSLog(@"竖屏");
    } else {
        //UIDeviceOrientationIsLandscape(device.orientation);
        NSLog(@"横屏");
    }
    
}

- (void)prepareView {
    
    [self addChildViewController:self.tableViewController];
    [self addChildViewController:self.viewController];
    
    [self.view addSubview:self.tableViewController.tableView];
    [self.view addSubview:self.viewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark
#pragma mark - UITraitEnvironment


- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    NSLog(@"%@",self.traitCollection);
}


#pragma mark
#pragma mark - lazy

- (LeftTableViewController *)tableViewController {
    if (!_tableViewController) {
        _tableViewController = [[LeftTableViewController alloc] init];
        _tableViewController.view.frame = CGRectMake(0, 0, 100, [UIScreen mainScreen].bounds.size.height);
        _tableViewController.view.backgroundColor = [UIColor redColor];
    }
    return _tableViewController;
}

- (RightViewController *)viewController {
    if (!_viewController) {
        _viewController = [[RightViewController alloc] init];
        _viewController.view.backgroundColor = [UIColor blueColor];
        _viewController.view.frame = CGRectMake(100, 0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.height);
    }
    return _viewController;
}

@end
