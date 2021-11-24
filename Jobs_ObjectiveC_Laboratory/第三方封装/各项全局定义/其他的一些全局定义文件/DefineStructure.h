//
//  DefineStructure.h
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#ifndef DefineStructure_h
#define DefineStructure_h
// 此文件用来存储记录全局的一些枚举
typedef enum : NSInteger {
    DevEnviron_Cambodia_Main = 0,/// 柬埔寨（主要）开发环境
    DevEnviron_Cambodia_Minor,/// 柬埔寨（次要）开发环境
    DevEnviron_Cambodia_Rally,/// 柬埔寨Rally（次要）开发环境
    DevEnviron_China_Mainland,/// 中国大陆开发环境
    TestEnviron,/// 测试环境
    ProductEnviron,/// 生产环境
    UATEnviron/// UAT环境地址
} NetworkingEnvir;
/// 来源:0、苹果；1、安卓；2、H5
typedef enum : NSInteger {
    originType_Apple = 0,
    originType_Android,
    originType_H5
} originType;

typedef enum : NSInteger {
    InType = 0,//收入
    OutType//支出
} InOutType;
/// 来源:0、系统消息；1、粉丝消息；2、评论消息
typedef enum : NSInteger {
    DDMsgTBVCellType_SYS = 0,
    DDMsgTBVCellType_Fans,
    DDMsgTBVCellType_Comment
} DDMsgTBVCellType;
/// 资源位置
typedef enum : NSInteger {
    UsersPostList = 0,// 帖子列表（单个用户发帖的详情列表+多个用户的发帖的列表）
    UsersPostDetail// 帖子详情（具体的某个用户的具体的某个帖子的详情）
} UserPost;
/// 用户选择的资源类型
typedef enum : NSInteger {
    selectedVideoType = 0,// 选择的是视频,
    selectedPicType// 选择的是图片,
} selectedType;
/// 关注的方向
typedef enum : NSInteger {
    FocusOnMe = 0,//关注我的
    FocusOnOthers//我关注别人的
} FocusOnStyle;
/// banner位置：0、首页；1、社区
typedef enum : NSInteger {
    BannerType_Home = 0,
    BannerType_Community
} BannerType;
//0、关注；1、点赞；2、发布；3、评论
typedef enum : NSInteger {
    MyPostType_attention = 0,//  关注
    MyPostType_like,// 点赞
    MyPostType_release,// 发布
    MyPostType_comment// 评论
} MyPostType;
// 外层只显示最多三条评论数据，内层全显示
typedef enum : NSInteger {
    DDCollectionViewCell_Style2Type_normal = 0,//位置：外层的一般列表
    DDCollectionViewCell_Style2Type_detail//位置：详情
} DDCollectionViewCell_Style2Type;

typedef enum : NSInteger {
    MessageType_invitationMsg = 0,//邀请奖励
    MessageType_collectMsg,//收藏奖励
    MessageType_videoCheckMsg,//审核视频奖励
    MessageType_postCheckMsg,//帖子审核
    MessageType_vipExpireMsg,//会员到期
    MessageType_rechargeSucceeMsg,//充值成功
    MessageType_backgroundMsg//后台消息
} MessageType;

typedef enum : NSInteger {
    DDMemberRightViewType_permanent = 1,//永久卡
    DDMemberRightViewType_year,//钻石年卡
    DDMemberRightViewType_quarter,//白金季卡
    DDMemberRightViewType_month//黄金月卡
} DDMemberRightViewType;

typedef enum : NSInteger {
    FeedBackType_Unknown = -1,//未赋值的状态
    FeedBackType_FunctionalDefect,//功能缺陷
    FeedBackType_UE,//用户体验
    FeedBackType_Other//其他
} FeedBackType;

typedef enum : NSInteger {
    MyLove_ShortVideoType = 0,// 我的喜欢（短视频）
    MyLove_LongVideoType,// 我的喜欢（长视频）
    MyRelease_ShortVideoType// 我的发布（只有短视频）
} VideoType;
// 0、男 1、女 2、保密
typedef enum : NSInteger {
    SexType_Man = 0,// 男
    SexType_Woman,// 女
    SexType_Unknown// 保密
} SexType;

typedef enum : NSInteger {
    DDWaterBillType_Earn = 0,// 获得 MoneyType (4、签到；9、邀请好友；11、充值)
    DDWaterBillType_Consume = 1,// 消费 MoneyType (10、会员开通）
    DDWaterBillType_Deposit = 5,// 存款 充值
    DDWaterBillType_Transfer = 6// 转账 转账
} DDWaterBillType;

typedef enum : NSInteger {
    MoneyType_CustomerRecharge = 0,//客服充值
    MoneyType_Alipay = 1,//支付宝
    MoneyType_Wechat = 2,//微信话费
    MoneyType_Deposit = 5,//存款
    MoneyType_Transfer = 6,//转账
    MoneyType_MembersOpened = 7,//会员开通
    MoneyType_VIP = 10,//会员开通
    MoneyType_Recharge = 11,//充值
    MoneyType_SignIn = 12,//签到
    MoneyType_Invite = 13,//邀请好友
    MoneyType_WatchVideo = 14,//观看视频
    MoneyType_VideoCollection = 15,//收藏视频
    MoneyType_MembersPresent = 16//会员赠送
} MoneyType;

typedef enum : NSInteger {
    TransferPromptViewType = 0,// 转账成功提示
    RechargePromptViewType,// 充值成功提示
    AliPayPromptViewType,// 没有安装支付宝原生提示
    WechatPayPromptViewType// 没有安装微信原生提示
} PromptViewType;

typedef enum : NSInteger {
    VipLevel_Expired = 0,//已过期
    VipLevel_Gold,//黄金会员
    VipLevel_Platina,//白金会员
    VipLevel_Diamond,//钻石会员
    VipLevel_Permanent//永久会员
} VipLevel;

typedef enum : NSInteger {
    VipType_Permanent = 1,//永久会员
    VipType_Diamond,//钻石会员
    VipType_Platina,//白金会员
    VipType_Gold//黄金会员
} VipType;

typedef enum : NSInteger {
    DDWalletViewType_0 = 0,//抖动钱包
    DDWalletViewType_1//抖币
} DDWalletViewType;

typedef enum : NSInteger {
    DDSendType_AppDoor = 0,//注册登录
    DDSendType_BindBankCard,//绑定银行卡
    DDSendType_FindCode,//找回密码
    DDSendType_BindTel//绑定手机号
} DDSendType;
/// 审核状态
typedef enum : NSInteger {
    CheckType_processing = 0,// 审核中
    CheckType_approve,// 审核通过
    CheckType_unapprove// 审核未通过
} CheckType;
/// 消息状态相关接口
typedef enum : NSInteger {
    MessageStatusType_Msg = 0,// 消息
    MessageStatusType_Fans,// 粉丝
    MessageStatusType_Comment// 评论
} MessageStatusType;
/// app版本更新状态相关接口
typedef enum : NSInteger {
    AppVersionUpdateNormal = 0,// 不更新
    AppVersionUpdateUnforced,// 非强制更新
    AppVersionUpdateForced// 强制更新
} AppVersionUpdate;
/// 发送短信类型
typedef enum : NSInteger {
    SendTypeLogin = 0,// 注册登录
    SendTypeBindingBankCard,// 绑定银行卡
    SendTypeFindCode,// 找回密码
    SendTypeBindingTel// 绑定手机号
} SendType;

typedef enum : NSInteger {
    VIP界面 = 1,
    充值界面,
    上传短视频界面,
    上传帖子界面
} 界面;

typedef enum : NSInteger {
    DDLocation_Top = 0,
    DDLocation_Left,
    DDLocation_Bottom,
    DDLocation_Right,
    DDLocation_Centre
} DDLocation;

typedef enum : NSInteger {
    DDCoinTypeLong = 0,
    DDCoinTypeSort
} DDCoinType;

typedef enum : NSInteger {
    DDPayMethod_customerService = -1,// 客服
    DDPayMethod_alipay = 0,// 支付宝
    DDPayMethod_wechat,// 微信
    DDPayMethod_other// 其他
} DDPayMethod;

#endif /* DefineStructure_h */
