//
//  ViewController.m
//  YQNavItem
//
//  Created by liuyunqing on 16/1/18.
//  Copyright © 2016年 chase_liu. All rights reserved.
//

#import "ViewController.h"
#import "YQFirstViewController.h"
#import "YQSecondViewController.h"
#import "YQThirdViewController.h"

#define YQWidth [UIScreen mainScreen].bounds.size.width
#define YQHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) YQFirstViewController *firstVC;
@property (nonatomic, strong) YQSecondViewController *secondVC;
@property (nonatomic, strong) YQThirdViewController *thirdVC;
@property (nonatomic, strong) UIViewController *currentVC;

@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) NSMutableArray *headArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YQ网易Demo";
    self.view.backgroundColor = [UIColor greenColor];
    self.headArray = [NSMutableArray arrayWithObjects:@"头条", @"娱乐", @"体育", @"财经", @"金融", @"热门", @"NBA", nil];
    [self createView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, YQWidth, 40)];
    _headerScrollView.backgroundColor = [UIColor purpleColor];
    _headerScrollView.contentSize = CGSizeMake(560, 0);
    _headerScrollView.bounces = NO;
    _headerScrollView.pagingEnabled = YES;
    [self.view addSubview:_headerScrollView];
    
    for (int i = 0; i < [_headArray count]; i++) {
        UIButton *YQButton = [[UIButton alloc] initWithFrame:CGRectMake(0 + i * 80, 0, 80, 40)];
        [YQButton setTitle:[_headArray objectAtIndex:i] forState:UIControlStateNormal];
        YQButton.tag = 100 + i;
        YQButton.backgroundColor = [UIColor blackColor];
        [YQButton addTarget:self action:@selector(YQButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headerScrollView addSubview:YQButton];
    }
    
    self.firstVC = [[YQFirstViewController alloc] init];
    _firstVC.view.frame = CGRectMake(0, 104, YQWidth, YQHeight - 40);
    [self addChildViewController:_firstVC];
    
    self.secondVC = [[YQSecondViewController alloc] init];
    _secondVC.view.frame = CGRectMake(0, 104, YQWidth, YQHeight - 40);
    [self addChildViewController:_secondVC];
    
    self.thirdVC = [[YQThirdViewController alloc] init];
    _thirdVC.view.frame = CGRectMake(0, 104, YQWidth, YQHeight - 40);
    [self addChildViewController:_thirdVC];
    
    // 默认视图
    [self.view addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
    
}

- (void)YQButtonClickAction:(UIButton *)button
{
    // 判断是否是当前页
    if ((self.currentVC == self.firstVC && button.tag == 100)||(self.currentVC == self.secondVC && button.tag == 101) || (self.currentVC == self.thirdVC && button.tag == 102)) {
        return;
    }else{
        //只写了3个 多个自行补全
        switch (button.tag) {
            case 100:
                [self replaceController:self.currentVC newController:self.firstVC];
                break;
            case 101:
                [self replaceController:self.currentVC newController:self.secondVC];
                break;
            case 102:
                [self replaceController:self.currentVC newController:self.thirdVC];
                break;
            default:
                break;
        }
    }
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        }else{
            self.currentVC = oldController;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
