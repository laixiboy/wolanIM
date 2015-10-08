//
//  wolanDataModel.m
//  wolanIM
//
//  Created by yushaojun on 15/9/22.
//  Copyright (c) 2015年 wolan. All rights reserved.
//

#import "wolanDataModel_MyInfo.h"

@implementation wolanDataModel_MyInfo

@synthesize id = _id;
@synthesize type = _type;
@synthesize isVIP = _isVIP;
@synthesize isVerify = _isVerify;
@synthesize myTitle = _myTitle;
@synthesize image = _image;
@synthesize numAnswer = _numAnswer;//今日参与人数
@synthesize numAnswerPass = _numAnswerPass;//及格
@synthesize numAnswer_History = _numAnswer_History;//历史参与人数
@synthesize numAnswerPass_History = _numAnswerPass_History;//历史及格
@synthesize numQuestion = _numQuestion;

@end
