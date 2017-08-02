//
//  WeChatHeader.h
//  WechatPod
//
//  Created by monkey on 2017/8/2.
//  Copyright © 2017年 Coder. All rights reserved.
//

#ifndef WeChatHeader_h
#define WeChatHeader_h

#import <UIKit/UIKit.h>

@interface CMessageWrap

@property(nonatomic, strong) NSString* m_nsContent;        //发送消息的内容
@property(retain, nonatomic) NSString* m_nsToUsr;          //发送人
@property(retain, nonatomic) NSString* m_nsFromUsr;        //接收人
@property(assign, nonatomic) unsigned long m_uiStatus;
@property(assign, nonatomic) unsigned long m_uiCreateTime;

+ (BOOL)isSenderFromMsgWrap:(CMessageWrap*) msgWrap;

- (CMessageWrap*)initWithMsgType:(int) type;

@end

@interface MMServiceCenter

- (id)getService:(Class) name;

@end

@interface CMessageMgr

- (void)AddLocalMsg:(NSString*)from MsgWrap:(CMessageWrap*) msgWrap;

@end

#endif /* WeChatHeader_h */
