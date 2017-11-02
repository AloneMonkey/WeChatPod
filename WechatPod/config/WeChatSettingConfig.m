//
//  WeChatSettingConfig.m
//  WechatPod
//
//  Created by monkey on 2017/10/26.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "WeChatSettingConfig.h"
#import <CaptainHook/CaptainHook.h>
#import "WeChatPluginConfig.h"
#import <MDSettingCenter/MDSettingCenter.h>

#pragma mark NewMainFrameViewController

CHDeclareClass(NewMainFrameViewController);

CHOptimizedMethod(0, self, void, NewMainFrameViewController, viewDidLoad){
    CHSuper(0, NewMainFrameViewController, viewDidLoad);
    //add to window
    [[MDSuspendBall sharedInstance] addToWindow];
}

CHConstructor{
    CHLoadLateClass(NewMainFrameViewController);
    CHClassHook(0, NewMainFrameViewController, viewDidLoad);
}

CHConstructor{
    WeChatPluginConfig* pluginConfig = [WeChatPluginConfig sharedInstance];
    
    MDSettingsViewController* settingViewController = [MDSettingsViewController sharedInstance];
    
    MDSwitchData* switchData = [[MDSwitchData alloc] init];
    switchData.title = @"消息防撤回";
    switchData.switchState = pluginConfig.enableRevoke;
    switchData.customCellBlock = ^(UITableViewCell *cell){
        //set cell style
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    switchData.switchBlock = ^(BOOL on) {
        pluginConfig.enableRevoke = on;
    };
    
    MDTextFieldData * stepData = [[MDTextFieldData alloc] init];
    stepData.title = @"微信步数";
    stepData.value = [@(pluginConfig.stepCount) stringValue];
    stepData.placeholder = @"修改的步数";
    stepData.maxLength = 5;
    stepData.customCellBlock = ^(UITableViewCell *cell){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    stepData.textFieldBlock = ^(UITextField *textField) {
        pluginConfig.stepCount = textField.text.integerValue;
    };
    
    MDTextFieldData * longitudeData = [[MDTextFieldData alloc] init];
    longitudeData.title = @"经度";
    longitudeData.placeholder = @"设置经度";
    longitudeData.customCellBlock = ^(UITableViewCell *cell){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    longitudeData.textFieldBlock = ^(UITextField *textField) {
        pluginConfig.longitude = textField.text.doubleValue;
    };
    
    MDTextFieldData * latitudeData = [[MDTextFieldData alloc] init];
    latitudeData.title = @"纬度";
    latitudeData.placeholder = @"设置纬度";
    latitudeData.customCellBlock = ^(UITableViewCell *cell){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    latitudeData.textFieldBlock = ^(UITextField *textField) {
        pluginConfig.latitude = textField.text.doubleValue;
    };
    
    MDSegmentData* gameData = [[MDSegmentData alloc] init];
    gameData.title = @"游戏作弊";
    gameData.items = @[@"剪刀", @"石头", @"布"];
    gameData.customCellBlock = ^(UITableViewCell *cell){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    gameData.segmentBlock = ^(UISegmentedControl *segment) {
        pluginConfig.gameNumber = segment.selectedSegmentIndex + 1;
    };
    
    MDStepperData* gameNumberData = [[MDStepperData alloc] init];
    gameNumberData.title = @"骰子点数";
    gameNumberData.min = @(1);
    gameNumberData.max = @(6);
    gameNumberData.step = @(1);
    gameNumberData.customCellBlock = ^(UITableViewCell *cell){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    gameNumberData.stepperBlock = ^(double value) {
        pluginConfig.gameNumber = (int)value + 3;
    };
    
    NSArray* groupArr = @[switchData, stepData, longitudeData, latitudeData, gameData, gameNumberData];
    
    MDTableViewGroup *group = [[MDTableViewGroup alloc] initWithTitle:@"WeChatPod" footer:@"by AloneMonkey" cells:groupArr];
    
    [settingViewController addTableViewGroup:group];
}
