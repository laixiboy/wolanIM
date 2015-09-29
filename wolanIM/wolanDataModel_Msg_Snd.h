

#ifndef wolanIM_wolanUserModel_Msg_Snd_h
#define wolanIM_wolanUserModel_Msg_Snd_h

//
// @brief:DataModel of TableViewCell which show Question
// @author:wolan

#import <Foundation/Foundation.h>

@interface wolanDataModel_Msg_Snd : NSObject

@property (nonatomic) long id;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSDate* date;
@property (nonatomic) BOOL isRead;

@end


#endif
