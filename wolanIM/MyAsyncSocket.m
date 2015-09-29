//
//  @func:AsyncSocket Base Class
//  @author:wolan
//

#import "GCDAsyncSocket.h"
#import "MyAsyncSocketConfig.h"
#import "MyAsyncSocket.h"


@interface MyAsyncSocket() <GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *_asyncSocket;
}
@end

@implementation MyAsyncSocket

-(instancetype)init
{
    if(self=[super init])
    {
        //让delegate发生在主线程中
        _asyncSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

-(void)dealloc
{
    _asyncSocket.delegate = nil;
    _asyncSocket = nil;
}

-(void)connectWithHost:(NSString *)host port:(int)port
{
    NSError *error = nil;
    [_asyncSocket connectToHost:host onPort:port error:&error];
    if(error)
    {
        CommuLog(@"[MyAsyncSocket]connectWithHost:%@",error.description);
        if(_delegate && [_delegate respondsToSelector:@selector(didDisconnectWithError)])
        {
            [_delegate didDisconnectWithError:error];
        }
    }
}

-(void)disconnect
{
    [_asyncSocket disconnect];
}


-(BOOL)isConnected
{
    return [_asyncSocket isConnected];
}

-(void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag
{
    [_asyncSocket readDataWithTimeout:timeout tag:tag];
}

-(void)writeData:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag
{
    [_asyncSocket writeData:data withTimeout:timeout tag:tag];
}

//标记是实现的协议的函数
#pragma mark -
#pragma GCDAsyncSocketDelegate method

-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    CommuLog(@"[MyAsyncSocket]SocketDidDisconnect:%@",err.description);
    if(_delegate && [_delegate respondsToSelector:@selector(didDisconnectWithError:)])
    {
        [_delegate didDisconnectWithError:err];
    }
}

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    CommuLog(@"[MyAsyncSocket]sock disConnectToHost:%@:%i",host,port);
    if(_delegate && [_delegate respondsToSelector:@selector(didConnectToHost:port:)])
    {
        [_delegate didConnectToHost:host port:port];
    }
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    CommuLog(@"[MyAsyncSocket]sock didReadData:%lu,%li",(unsigned long)data.length,tag);
    if(_delegate && [_delegate respondsToSelector:@selector(didReceiveData:tag:)])
    {
        [_delegate didReceiveData:data tag:tag];
    }
    [sock readDataWithTimeout:-1 tag:tag];
}

-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    CommuLog(@"[MyAsyncSocket]sock disWriteDataWithTag:%li",tag);
    [sock readDataWithTimeout:-1 tag:tag];
}


@end
