//
//  ViewController.m
//  ceshi
//
//  Created by xiehewanbang on 2018/8/17.
//  Copyright © 2018年 xiehewanbang. All rights reserved.
//

#import "ViewController.h"
#import "TestVC.h"

@interface ViewController ()

@property (nonatomic,strong)  UILabel  *  mLabel ;
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
  
//#ifdef APPSTORE_PACKAGE
//    NSLog(@"APPSTORE_PACKAGE");
//#else
//    NSLog(@"APPSTORE_PACKAGENONONONONONO");
//#endif
    
    UIView *view = self.testView;
    UIView *superView = view.superview;
    [superView.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop)
     {
         if ((constraint.firstItem == view )&&(constraint.firstAttribute == NSLayoutAttributeLeading))
         {
             constraint.constant = 0;
         }
     }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[TestVC new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+(NSInteger)returnNumber
{
    return 3;
}
@end
