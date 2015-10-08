

#ifndef wolanIM_wolanUserModel_Msg_Rec_h
#define wolanIM_wolanUserModel_Msg_Rec_h

//
// @brief:DataModel of TableViewCell which show Question
// @author:wolan

#import <Foundation/Foundation.h>

@interface wolanDataModel_MyInfo : NSObject

@property (nonatomic) long id;
@property (nonatomic) short type;
@property (nonatomic) BOOL isVIP;
@property (nonatomic) BOOL isVerify;
@property (nonatomic,copy) NSString* myTitle;
@property (nonatomic,copy) NSString* image;
@property (nonatomic) short numAnswer;//今日参与人数
@property (nonatomic) short numAnswerPass;//及格
@property (nonatomic) short numAnswer_History;//历史参与人数
@property (nonatomic) short numAnswerPass_History;//历史及格
@property (nonatomic) short numQuestion;

@end


#endif
