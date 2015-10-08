//
//  wolanAppDelegate.h
//  wolanIM
//
//  Created by laixiboy on 15-8-25.
//  Copyright (c) 2015年 wolan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wolanLogin.h"
#import "wolanHomeViewController.h"
#import "wolanMsgViewController.h"
#import "wolanMyInfoViewController.h"

@interface wolanAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
    wolanLogin *loginTableView;
    wolanHomeViewController *homeTableView;
    wolanMyInfoViewController *myTableView;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly) BOOL applicationActive;


-(void)InitMainTabBarView;

@end
