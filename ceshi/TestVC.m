//
//  TestVC.m
//  ceshi
//
//  Created by xiehewanbang on 2019/3/11.
//  Copyright © 2019年 xiehewanbang. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"first page";
    
    
    //间隔
    UIBarButtonItem *backNegativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
    backNegativeSpacer.width = -30;
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    backButton.backgroundColor = [UIColor greenColor];
    [backButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backItem   = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    //    backItem.style = UIBarButtonItemStylePlain;
    NSMutableArray *leftButtonsArray = [NSMutableArray new];
    [leftButtonsArray addObject:backNegativeSpacer];
    [leftButtonsArray addObject:backItem];
    
    
    self.navigationItem.leftBarButtonItems =leftButtonsArray ;

}

-(void)goBackClick
{
        [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
