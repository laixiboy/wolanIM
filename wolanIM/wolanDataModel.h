

#ifndef wolanIM_wolanUserModel_h
#define wolanIM_wolanUserModel_h

//
// @brief:DataModel of TableViewCell which show Question
// @author:wolan

#import <Foundation/Foundation.h>

@interface wolanDataModel : NSObject

@property (nonatomic) long id;
@property (nonatomic,copy) NSString* intro;
@property (nonatomic) BOOL gender;//Yes:male NO:female
@property (nonatomic) BOOL gender_verify;
@property (nonatomic) short height;
@property (nonatomic) short weight;
@property (nonatomic) short age;
@property (nonatomic) short work_id;//工作类型代码
@property (nonatomic) short city_id;//城市代码
@property (nonatomic,copy) NSDate* date;


@end


#endif
