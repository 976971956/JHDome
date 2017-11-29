//
//  InterfaceHeader.h
//  项目基本框架
//
//  Created by 王志威 on 2017/3/17.
//  Copyright © 2017年 王志威. All rights reserved.
//

#ifndef InterfaceHeader_h
#define InterfaceHeader_h
//定义接口数据
#define TJ_HOST @"https://api.tuiji.net"

//#define TJ_HOST @"http://120.24.44.99"
#define LOGIN_PMT @"/v2/account/login"//登录
#define LOGOUT @"/v2/account/logout"
#define LOGIN_ACCOUNT @"/v2/account/auth/refresh_token"//登录刷新的token

#define RIGST_PMT @"/api/user/register"//注册
#define CODE_PMT @"/api/user/register/msgcode"//验证码
#define FORGOTPWD1 @"/api/personal/forgotpw/getSMSCode"//忘记密码获取验证码
#define FORGOTPWD2 @"/api/personal/forgotpw/checkSMSCode"//忘记密码验证验证码
#define FORGOTPWD3 @"/api/personal/forgotpw/changepw"//忘记密码


#define GETFRENDDATAS @"/api/updateRemark"//获取好友所有信息
//获取七牛token
#define GETQINIUtoken @"/api/qiniu/uploadToken"
//根据手机号推几号找用户加载信息
#define GETUSERInfo @"/api/user/loadAllInfo"
/*--------------------------好友模块-----------------------------------------------------------------*/
//删除一个好友
#define DELETEFREND @"/v2/contacts/me/friends"
//查询所有好友请求
#define SELECTMESSAGE @"/v2/contacts/me/friends/requests"
//添加备注
#define UPDATEREMARK @"/v2/contacts/me/friends"
//获取用户所有好友
#define FINDALL @"/v2/contacts/me/friends"
//回复好友请求
#define FRIENDREQUEST @"/v2/contacts/me/friends"
//添加好友请求
#define INSERTFRIEND @"/v2/contacts/me/friends"


/*--------------------------个人模块-----------------------------------------------------------------*/

//个人推文
#define GETTWEET @"/api/circle/getTweet"
//获取含有图片的推文列表
#define IMGLIST @"/api/personal/tweet/imgList"
//修改个人信息
#define EDITMESSAGEINFO @"/api/personal/edit"

//用户查看个人收藏接口
#define SELECTCOLLECTION @"/api/selectCollection"
//推己圈点赞
#define TJQDIANZAN @"/api/circle/praise"
//删除推文
#define DELETETWEET @"/api/circle/deleteTweet"
//编辑推文
#define EDITTWEET @"/api/circle/editTweet"
//帮助中心
#define HELP_INFO @"/v2/feedback"
/*---------------------------------------推己圈---------------------------------------------------*/
//用户在推己圈写推文的接口
//写推文，发布到推己圈 (纯文字、图文混编、纯图片、图音混编、小视频)
#define WRITETWEET @"/api/circle/writeTweet"
//(推己圈)查看推文点赞列表
#define GETPRAISE @"/api/circle/getPraise"
//(推己圈)查看推文评论列表
#define GETCOMMENTS @"/api/circle/getComments"
//(推己圈)用户在推己圈评论推文的接口
#define COMMENT @"/api/circle/comment"
//(推己圈)删除推文下单条的评论
#define DELETECOMMENT @"/v2/timeline/posts/comment"
//(推己圈)收藏推文的接口
#define COLLECT @"/api/circle/collect"
//(推己圈)看小视频时统计播放次数,并通知主人
#define WATCHVIDEO @"/api/circle/watchVideo"
//转发推文
#define TURNTWEET @"/api/circle/turnTweet"
//单条推文
#define TWEET @"/api/circle/tweet"
/*---------------------------------------广场---------------------------------------------------*/
//(广场)查询某推文的父评论
#define SELECTFATHERCOMMENT @"/api/selectFatherComment"
//(广场)查询父评论下的所有子评论
#define SELECTSONCOMMENT @"/api/selectSonComment"
//(广场)删除评论
#define GCDELETECOMMENT @"/api/deleteComment"
//(广场)广场评论推文接口
#define COMMENTTWEET @"/api/commentTweet"
//(广场)收藏他人推文
#define COLLECTTWEET @"/api/collectTweet"
//(广场)**获取用户关注的所有信息
#define SELECTATTENTION @"/api/selectAttention"
//(广场)查询最新12条推文
#define SELECTTWEET @"/api/selectTweet"
//(广场)添加广场视频播放次数
#define GCWATCHVIDEO @"/api/square/watchVideo"
//(广场)通过推文id查询推文内容
#define SELECTTWEETCONTEXT @"/api/selectTweetContext"
//(广场)推文点赞
#define GCDIANZAN @"/api/praiseTweet"
//(广场)取消点赞
#define CANCELPRAISE @"/api/cancelPraise"
//(世界)-初始化全球数据
#define LOADWORLDS @"/world/api/loadWorlds" 
//(世界)-下拉刷新
#define LOADNEWWORLDS @"/world/api/loadNewWorlds"
//（世界）-上拉加载
#define LOADOLDWORLDS @"/world/api/loadOldWorlds"
//（世界）(新闻详情)
#define NEWSDETALS @"/news/newsDetails"
//(世界)（收藏）
#define COLLECTION @"/world/api/collection"
//(世界) 搜索
#define SEARCHNAME @"/api/searchName"

//获取用户关注者
#define SELECTATTENTIONED @"/api/selectAttentioned"

//取消关注接口
#define CANCELATTENTION @"/api/cancelAttention"
//关注
#define ATTENTIONUSER @"/api/attentionUser"

//修改用户的扩展信息接口
#define EDITUINFOEX @"/api/personal/editUInfoEx"
//获取用户的扩展信息
#define UINFOEX @"/api/personal/uInfoEx"


//------------------------------------------------百度api-------------------------------------------------
#define BAIDUFANYIAPI @"https://fanyi-api.baidu.com/api/trans/vip/translate"

#endif /* InterfaceHeader_h */
