

#ifndef wolanIM_wolanUserModel_Msg_h
#define wolanIM_wolanUserModel_Msg_h

//
// @brief:DataModel of TableViewCell which show Question
// @author:wolan

#import <Foundation/Foundation.h>

@interface wolanDataModel_Msg : NSObject

@property (nonatomic) long id;
@property (nonatomic) short value;
@property (nonatomic,copy) NSString* image;
@property (nonatomic,copy) NSString* title;

@end


#endif
