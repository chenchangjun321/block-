//
//  AppDelegate.m
//  ceshi
//
//  Created by xiehewanbang on 2018/8/17.
//  Copyright © 2018年 xiehewanbang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic,copy)  NSString  *  mTitle ;

@property (nonatomic,strong)   void (^mBlock) (int x);

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
//    self.window.rootViewController = nav;
    
    //全局区---
    //1.只要，没有引用外部变量，都在全局区，
    //2,全局区block copy后的新block，没有新block生成
    //3.全局区的block强引Block以后，没有新block生成

    
    //栈区---
    //1.且有引用外部变量，__weak 修饰block，在栈区
    //2,栈区block copy后的新block，新的block 会在堆区，原来block 不变
    //3.栈区的block强引Block以后，新的block 会在堆区，原来block 不变

    //堆区--
    //1.引用外部变量(无论变量用什么修饰)，无__weak 修饰block，在堆
    //2,堆区block copy后的新block，没有新block生成
    //3.堆区的block强引Block以后，没有新block生成

//    [self func14];

    Class   cls  =   NSClassFromString(@"ViewController");
    int num =   [cls performSelector:@selector(returnNumber)];
    NSLog(@"%d",num);
    return YES;
}


-(void)func1
{
    //全局区
    //没有__weak（修饰block） 没有引用外部变量
    void (^block1) (int x);
    block1 = ^(int x){
        int result = x+100;
        NSLog(@"%d",result);
    };
    NSLog(@"block1:%@",block1);
    block1(10);
    
}

-(void)func2
{
    //全局区
    //有__weak（修饰block） 没有引用外部变量
    __weak void (^block2) (int x)= ^(int x){
        int  result = x+100;
        NSLog(@"%d",result);
    };
    NSLog(@"block2%@",block2);
    block2(10);
}




-(void)func3
{
    //栈区
    //有__weak（修饰block） 有引用外部变量
    int n = 100;
    __weak void (^block2) (int x)= ^(int x){
        int  result = x+n;
        NSLog(@"%d",result);
    };
    NSLog(@"block2%@",block2);
    block2(10);
}



-(void)func4
{
    //堆区
    // 有引用外部变量 __block 修饰
    __block    int n = 100;
     void (^block2) (int x)= ^(int x){
        int  result = x+n;
        NSLog(@"%d",result);
    };
    NSLog(@"block2%@",block2);
    block2(10);
}

-(void)func5
{
    //堆区
    //有引用外部变量 无 __block 修饰
    int n = 100;
    void (^block2) (int x)= ^(int x){
        int  result = x+n;
        NSLog(@"%d",result);
    };
    NSLog(@"block2%@",block2);
    block2(10);
}

-(void)func6
{
    //堆区
    //有引用外部变量(成员变量)
    self.mTitle = @"123";
    void (^block2) (int x)= ^(int x){
        int  result = x+1;
        NSLog(@"%d",result);
        NSString *tempString = self.mTitle;
        NSLog(@"%@",tempString);
    };
    NSLog(@"block2%@",block2);
    block2(10);
}


-(void)func7
{
    //堆区
    //有引用外部变量(成员变量)
    
    __weak typeof(self)weakSelf = self;
    void (^block2) (int x)= ^(int x){
        int  result = x+1;
        NSLog(@"%d",result);
        NSString *tempString = weakSelf.mTitle;
        NSLog(@"%@",tempString);
    };
    NSLog(@"block2%@",block2);
    block2(10);
}

#pragma  mark  =============================  copy   ======================================


-(void)func8
{
    //---全局区copy
    //结果：在全局区-----地址不变
    //还是在全局区
    void (^block2) (int x)= ^(int x){
        int  result = x+1;
        NSLog(@"%d",result);
    };
    NSLog(@"block2%@",block2);
    block2(10);
    void (^block3 ) (int x) = [block2 copy];
    NSLog(@"block2%@",block2);
    NSLog(@"block3%@",block3);
    
}

-(void)func9
{
    //---栈区copy
    //结果：在堆区---地址改变
    //有__weak（修饰block） 有引用外部变量， copy 后 新block 在堆，原来不变
    int n = 100;
    __weak void (^block2) (int x)= ^(int x){
        int  result = x+n;
        NSLog(@"%d",result);
    };
    NSLog(@"block2%@",block2);
    block2(10);
    void (^block3 ) (int x) = [block2 copy];
    NSLog(@"block2%@",block2);
    NSLog(@"block3%@",block3);
}


-(void)func10
{
    //---堆区copy
    //结果：在堆区--------地址不变
    //有引用外部变量(成员变量)
    __weak typeof(self)weakSelf = self;
    void (^block2) (int x)= ^(int x){
        int  result = x+1;
        NSLog(@"%d",result);
        NSString *tempString = weakSelf.mTitle;
        NSLog(@"%@",tempString);
    };
    NSLog(@"block2%@",block2);
    block2(10);
    void (^block3 ) (int x) = [block2 copy];
    NSLog(@"block2%@",block2);
    NSLog(@"block3%@",block3);

}

#pragma  mark  =============================  强引用   ======================================
-(void)func11
{
    //---全局区strong 引用Block
    //结果：在全局区-----地址不变
    void (^block1) (int x);
    block1 = ^(int x){
        int result = x+100;
        NSLog(@"%d",result);
    };
    NSLog(@"block1:%@",block1);
    block1(10);
    self.mBlock = block1;
    NSLog(@"block1:%@",block1);
    NSLog(@"block:%@", self.mBlock);
}

-(void)func12
{
    //---栈区的block强引Block以后
    //结果：在堆区--新地址生成
    int n = 100;
    __weak void (^block2) (int x)= ^(int x){
        int  result = x+n;
        NSLog(@"%d",result);
    };
    NSLog(@"block2%@",block2);
    block2(10);
    self.mBlock = block2;
    NSLog(@"block2:%@",block2);
    NSLog(@"block:%@", self.mBlock);
}

-(void)func13
{
    //---堆区的block强引Block以后
    //结果：在堆区--------地址不变（不会产生新的block）
    __weak typeof(self)weakSelf = self;
    void (^block2) (int x)= ^(int x){
        int  result = x+1;
        NSLog(@"%d",result);
        NSString *tempString = weakSelf.mTitle;
        NSLog(@"%@",tempString);
    };
    NSLog(@"block2%@",block2);
    block2(10);
    self.mBlock = block2;
    NSLog(@"block2:%@",block2);
    NSLog(@"block:%@", self.mBlock);
    
}

#pragma  mark  =============================  引用外部变量的方式   ======================================
-(void)func14
{
    //堆区
    //有引用外部变量 要改变外部变量要 __block 修饰 才可以
    //我们要改变外部变量的内存地址，也就是使用__block修饰符将外部变量在栈中指针的内存地址，迁移到堆区中来。
   // 因此，__block修饰符的根本操作就是改变外部变量的内存地址，并不是简单地使得写操作生效。
    __block    int n = 100;
    NSLog(@"%p",&n);
    NSLog(@"n:%d",n);
    void (^block2) (int x)= ^(int x){
        n=101;
        NSLog(@"%p",&n);
        NSLog(@"n:%d",n);
        int n ;
        NSLog(@"***%p",&n);
        NSLog(@"***n:%d",n);

    };

    block2(10);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
