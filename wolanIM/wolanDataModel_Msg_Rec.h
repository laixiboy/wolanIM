

#ifndef wolanIM_wolanUserModel_Msg_Rec_h
#define wolanIM_wolanUserModel_Msg_Rec_h

//
// @brief:DataModel of TableViewCell which show Question
// @author:wolan

#import <Foundation/Foundation.h>

@interface wolanDataModel_Msg_Rec : NSObject

@property (nonatomic) long id;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* image;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSDate* date;
@property (nonatomic) short score;//答案分数
@property (nonatomic) short credit;//信用
@property (nonatomic) short numComment;//评论条数

@end


#endif
