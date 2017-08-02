//
//  WeChatMessageHook.m
//  WechatPod
//
//  Created by monkey on 2017/8/2.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "CaptainHook.h"
#import "WeChatHeader.h"
#import "WeChatServiceManager.h"
#import "WeChatPluginConfig.h"
#import <Foundation/Foundation.h>

CHDeclareClass(CMessageMgr);

CHOptimizedMethod1(self, void, CMessageMgr, onRevokeMsg,CMessageWrap*, msgWrap){
    BOOL isSender = [objc_getClass("CMessageWrap") isSenderFromMsgWrap:msgWrap];
    
    if(!pluginConfig.enableRevoke || isSender){
        CHSuper1(CMessageMgr, onRevokeMsg, msgWrap);
        return;
    }
    
    CMessageWrap *newMsgWrap = [[objc_getClass("CMessageWrap") alloc] initWithMsgType:0x2710];
    
    NSString* revokePersonName = nil;
    
    //获取撤回人
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<!\\[CDATA\\[(.*?)撤回了一条消息\\]\\]>" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *result = [regex matchesInString:msgWrap.m_nsContent options:0 range:NSMakeRange(0, msgWrap.m_nsContent.length)].firstObject;
    
    if (result.numberOfRanges >= 2) {
        revokePersonName = [msgWrap.m_nsContent substringWithRange:[result rangeAtIndex:1]];
    }
    
    NSString* sendContent = [NSString stringWithFormat:@"%@ 撤回了消息", revokePersonName ? revokePersonName : msgWrap.m_nsFromUsr];
    
    [newMsgWrap setM_uiStatus:0x4];
    [newMsgWrap setM_nsContent:sendContent];
    [newMsgWrap setM_nsToUsr:msgWrap.m_nsToUsr];
    [newMsgWrap setM_nsFromUsr:msgWrap.m_nsFromUsr];
    [newMsgWrap setM_uiCreateTime:[msgWrap m_uiCreateTime]];
    
    [[WeChatServiceManager sharedCMessageMgr] AddLocalMsg:msgWrap.m_nsFromUsr MsgWrap:newMsgWrap];
}

CHConstructor{
    CHLoadLateClass(CMessageMgr);
    CHClassHook1(CMessageMgr, onRevokeMsg);
}
