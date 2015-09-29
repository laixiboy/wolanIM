//
//  AsyncSocket.h
//  wolanIM
//
//  Created by laixiboy on 15-8-27.
//  Copyright (c) 2015年 wolan. All rights reserved.
//

#import <Foundation/Foundation.h>

//ViewControl的代理
@protocol MyAsyncSocketDelegate<NSObject>

-(void)didDisconnectWithError:(NSString*)error;
-(void)didConnectToHost:(NSString*)host port:(int)port;
-(void)didReceiveData:(NSData*)data tag:(long)tag;

@end

@interface MyAsyncSocket : NSObject

@property (nonatomic,weak) id<MyAsyncSocketDelegate> delegate;

-(void)connectWithHost:(NSString*)host port:(int)port;
-(void)disconnect;

-(BOOL)isConnected;
-(void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag;
-(void)writeData:(NSData*)data timeout:(NSTimeInterval)timeout tag:(long)tag;

@end
