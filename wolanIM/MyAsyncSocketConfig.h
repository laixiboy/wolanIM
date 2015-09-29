//@func:通讯预定义

#ifndef _WOLANIM_MYASYNCSOCKET_H_
#define _WOLANIM_MYASYNCSOCKET_H_

#ifdef DEBUG
#define MYASYNCSOCKET_DEBUG
#endif

#ifdef MYASYNCSOCKET_DEBUG
#define CommuLog(format,...) NSLog(format,##__VA_ARGS__)
#else
#define CommuLog(format,...)
#endif

#endif