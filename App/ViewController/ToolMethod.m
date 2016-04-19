//
//  ToolMethod.m
//  Txs2.0Page
//
//  Created by homer on 15/9/14.
//  Copyright (c) 2015年 homer. All rights reserved.
//

#import "ToolMethod.h"
#import "LandingViewController.h"


@implementation ToolMethod

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)drawLineWithFrame:(CGRect)frame SuperView:(UIView *)bgView{
    
    UIBezierPath *linePath = [[UIBezierPath alloc]init];
    linePath.lineWidth = 2;
    [linePath moveToPoint:CGPointMake(0, 0)];//frame.origin.y + frame.size.height
    [linePath addLineToPoint:CGPointMake(frame.size.width, 0)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1] CGColor];
    lineLayer.lineWidth = 1;
    lineLayer.frame = frame;
    lineLayer.path = linePath.CGPath;
    [bgView.layer addSublayer:lineLayer];
}

+ (void)drawLineWithFrame:(CGRect)frame SuperView:(UIView *)bgView LineColor:(UIColor *)lineColor{
    
    UIBezierPath *linePath = [[UIBezierPath alloc]init];
    linePath.lineWidth = 2;
    [linePath moveToPoint:CGPointMake(0, 0)];//frame.origin.y + frame.size.height
    [linePath addLineToPoint:CGPointMake(frame.size.width, 0)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [lineColor CGColor];
    lineLayer.lineWidth = 1;
    lineLayer.frame = frame;
    lineLayer.path = linePath.CGPath;
    [bgView.layer addSublayer:lineLayer];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    //手机号以13， 15，18,17开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])｜(17[0,6-8]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileNum];
    
}

+ (BOOL)isidCardNumber:(NSString *)identityCard
{
    
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
    
}

+ (BOOL)isVerificationCode:(NSString *)Code
{
    NSString * ids = @"^\\d{6}$";//@"^[0-9]*$";
    NSPredicate *dicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ids];
    
    
    if ([dicate evaluateWithObject:Code] == YES)
        
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)numberDivision:(NSString *)number appendString:(NSString *)otherString{
    
    //    if ([number containsString:@"."]) { 此方法iOS8以上可用
    if ([number rangeOfString:@"."].location != NSNotFound) {
        NSArray *arrNumber = [[NSArray alloc]initWithArray:[number componentsSeparatedByString:@"."]];
        NSMutableString *arrInt = [[NSMutableString alloc]initWithString:[arrNumber firstObject]];
        int index = 0;
        for (int i = 1; i <= arrInt.length; i ++) {
            if (i % 3 == 0 && arrInt.length > (i + index)) {
                [arrInt insertString:@"," atIndex:arrInt.length - (i + index)];
                index ++;
            }
        }
        return [NSString stringWithFormat:@"%@.%@%@",arrInt,[arrNumber lastObject],otherString];
    } else {
    
        NSMutableString *arrInt = [[NSMutableString alloc]initWithString:number];
        int index = 0;
        for (int i = 1; i <= arrInt.length; i ++) {
            if (i % 3 == 0 && arrInt.length > (i + index)) {
                [arrInt insertString:@"," atIndex:arrInt.length - (i + index)];
                index ++;
            }
        }
        return [NSString stringWithFormat:@"%@%@",arrInt,otherString];
    }
}

/**
 *  是否是正常的金额
 *
 *  @return YES 表示正常
 */
+ (BOOL)isPassMount:(NSString *)amount{
    
    NSString *phoneRegex = @"^[0-9]*((\\.|,)[0-9]{0,2})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:amount];
}

/**
 *  是否是大于0的金额
 *
 *  @return YES 表示正常
 */
+ (BOOL)isAmountMoreThenZero:(NSString *)amount{
    
    return [amount floatValue] > 0 ;
}

/**
 *  是否是6位以上长度纯数字
 *
 *  @param stringText
 *
 *  @return
 */
+ (BOOL)isAllNumber:(NSString *)stringText{
    
    NSString *numberRegex = @"^\\d{6,}$";
    NSPredicate *nmberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [nmberTest evaluateWithObject:stringText];
}

/**
 *  是否是纯数字
 *
 *  @param stringText
 *
 *  @return
 */
+ (BOOL)isNumber:(NSString *)stringText{
    
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *nmberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [nmberTest evaluateWithObject:stringText];
}

//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
   
    //iOS7之后
    /*
     第一个参数: 预设空间 宽度固定  高度预设 一个最大值
     第二个参数: 行间距 如果超出范围是否截断
     第三个参数: 属性字典 可以设置字体大小
     */
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
//    NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"contentStrTime"];
//    
//    rect.size.height+=str.integerValue*10;
    //返回计算出的行高
    return rect.size.height;

}

/**
 *  计算两点距离
 *
 *  @param selfLatitude   自己的经度
 *  @param longitude      自己的纬度
 *  @param otherLatitude  别人经度
 *  @param otherLongitude 别人的纬度
 *
 *  @return 返回距离
 */
//+ (NSString *)calculationDistanceWithSelfLatitude:(NSString *)selfLatitude SelfLongitude:(NSString *)longitude OtherLatitude:(NSString *)otherLatitude OtherLongitude:(NSString *)otherLongitude{
//    if ([TangXSSingleton sharedInstance].isShowDistence) {
//        BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake([selfLatitude doubleValue],[longitude doubleValue]));
//        BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake([otherLatitude doubleValue],[otherLongitude doubleValue]));
//        CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
//        if (distance < 1000) {
//            return [NSString stringWithFormat:@"%d%@",(int)distance,@"m"];
//        } else {
//            if (distance > 50000) {
//                return @"50+km";//[NSString stringWithFormat:@"%.2f%@",distance*0.001,@"km"];
//            } else {
//                return [NSString stringWithFormat:@"%.1f%@",distance*0.001,@"km"];
//            }
//        }
//    } else {
//        return @"";
//    }
//}

/**
 *  @author homer, 15-11-09
 *
 *  设置导航栏title
 */
+ (void)settingNavbarTitle:(UIViewController *)viewController ForString:(NSString *)titleStr{
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 40, 30);
    label.textColor = [UIColor whiteColor];
    label.text = titleStr;
    viewController.navigationItem.titleView = label;
    
    [self addBackButton:viewController];
}

/**
 *  @author homer, 15-11-09
 *
 *  设置导航栏title
 */
+ (void)settingNavbarTitle:(UIViewController *)viewController ForString:(NSString *)titleStr IsCanBack:(BOOL)isAddBack{
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 40, 30);
    label.textColor = [UIColor whiteColor];
    label.text = titleStr;
    viewController.navigationItem.titleView = label;
    
    viewController.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    viewController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    if (isAddBack) {
       [self addBackButton:viewController];
    }
}

/**
 *  添加返回按钮
 */
+ (void)addBackButton:(UIViewController *)viewController{
    
    UIButton *btnBack = [[UIButton alloc]init];
    btnBack.backgroundColor = [UIColor clearColor];
    [btnBack addTarget:self action:@selector(backToProvious) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    btnBack.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    viewController.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];
    
    [[TangXSSingleton sharedInstance].arrTempViewController addObject:viewController];
}

/**
 *  返回上一页
 */
+ (void)backToProvious{
    
    UIViewController *tempViewController = [[TangXSSingleton sharedInstance].arrTempViewController lastObject];
    [tempViewController.navigationController popViewControllerAnimated:YES];
    [[TangXSSingleton sharedInstance].arrTempViewController removeLastObject];
}

/**
 *  添加公司名字
 *
 *  @param supview superview
 */
+ (void)addCompanyNameWithSuperView:(UIView *)supview{
    UILabel *lblCompany = [[UILabel alloc]init];
    lblCompany.frame = CGRectMake(0, kScreenHeight - 53, kScreenWidth, 12);
    lblCompany.text = @"资邦元达(上海)互联网金融信息服务有限公司出品";
    lblCompany.textAlignment = NSTextAlignmentCenter;
    lblCompany.textColor = RGBA(207, 207, 207, 1.0);
    lblCompany.font = [UIFont systemFontOfSize:12];
    [supview addSubview:lblCompany];
    
    UILabel *lblCopyRight = [[UILabel alloc]init];
    lblCopyRight.frame = CGRectMake(0, kScreenHeight - 33, kScreenWidth, 12);
    lblCopyRight.text = @"©2015zillion";
    lblCopyRight.textColor = RGBA(207, 207, 207, 1.0);
    lblCopyRight.font = [UIFont systemFontOfSize:12];
    lblCopyRight.textAlignment = NSTextAlignmentCenter;
    [supview addSubview:lblCopyRight];
    
}

/**
 *  未登录 去登录
 *
 *  @param viewController viewController
 */
+ (void)toLoginPage:(UIViewController *)viewController{
    LandingViewController *aa=[[LandingViewController alloc]init];
    [viewController.navigationController pushViewController:aa animated:YES];
}

/**
 *  未登录 去登录
 *
 *  @param viewController viewController
 *  @param FromPage push前进入的页面 //push进来的页面 1我的（未登陆） 2修改手机号 3(主页)
 */
+ (void)toLoginPage:(UIViewController *)viewController FromPage:(NSInteger)fromPage{
    LandingViewController *aa=[[LandingViewController alloc]init];
    aa.fromPage = fromPage;
    [viewController.navigationController pushViewController:aa animated:YES];
}

/**
 *  获取个人信息
 */
//+ (void)getUserInfo:(void(^)())SuccessBlock{
//    NSString *serviceAdress = [NSString stringWithFormat:kServerUrl,@"user/info"];
//    NSString *userToken = [[NSUserDefaults standardUserDefaults]objectForKey:kAccessToken];
//    if ([userToken isEqualToString:@""] || userToken == nil) {
//        NSLog(@"token null not netrequest");
//        return;
//    }
//    NSDictionary *parameterDic = @{@"accesstoken":userToken};
//    [[RequestNetwork manager]postSeverAddress:serviceAdress parameters:parameterDic success:^(id responseObject) {
//        
////        NSLog(@"getUserinfo--%@",responseObject);
//        NSString *requestResult = [[responseObject objectForKey:@"result"] stringValue];
//        if ([requestResult isEqualToString:@"1"]) {
//            //使用model保存个人信息到单例
//            NSDictionary *dictUserInfo = [responseObject objectForKey:@"accountinfo"];
//            MyWelfareModel *userinfo = [[MyWelfareModel alloc]init];
//            [userinfo setValuesForKeysWithDictionary:dictUserInfo];
//            [userinfo setValuesForKeysWithDictionary:responseObject];
//            if (dictUserInfo.count > 0) {
//                [TangXSSingleton sharedInstance].userInfoModel = userinfo;
//                SuccessBlock();
//            }
//            if ([userinfo.isglobalmaintenance boolValue]) {
//                //全局维护
//                UIImageView *imgGolbalmaintenance = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//                imgGolbalmaintenance.image = [UIImage imageNamed:@"systemMaintenance.png"];
//                [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:imgGolbalmaintenance];
//            }
//        } else {
//            if ([[responseObject objectForKey:@"errorcode"] isEqualToString:@"missing_parameter_accountid"]) {
//                NSLog(@"token失效");
//                //清除token等缓存
//                [ToolMethod clearDataWhenLogOut];
//            }
//            //请求失败
//            NSLog(@"getUserinfo_error_----%@",[responseObject objectForKey:@"errorcode"]);
//        }
//        
//    } failure:^(NSError *error) {
//        NSLog(@"getUserinfo_error_%@",error);
//    }];
//}

+(NSString*)getStringContent:(NSString *) contentStr{
    
    NSMutableString *tureStr=[[NSMutableString alloc]initWithString:contentStr];
    
    for (NSInteger i=0; i<1000000000; i++) {
        NSRange range = [tureStr rangeOfString:@"</p>"];
        if (range.location != NSNotFound) {
         [tureStr replaceCharactersInRange:range withString:@"\n"];
            
      }else{
        NSRange  rangeTwo = [tureStr rangeOfString:@"\n" options:NSBackwardsSearch];
          if (rangeTwo.location != NSNotFound){
             [tureStr replaceCharactersInRange:rangeTwo withString:@""];
        }
          break;
        }

    }
    
    for (NSInteger i=0; i<1000000000; i++) {
        NSRange range = [tureStr rangeOfString:@"<br/>"];
        if (range.location != NSNotFound) {
            [tureStr replaceCharactersInRange:range withString:@"\n"];
            
        }else{

            break;
        }
        
    }

    for (NSInteger i=0; i<1000000000; i++) {
        NSRange range = [tureStr rangeOfString:@"<p>"];
        if (range.location != NSNotFound) {
            [tureStr replaceCharactersInRange:range withString:@""];
        }else{
         
            break;
        }
        
    }
    for (NSInteger i=0; i<1000000000; i++) {
        NSRange range = [tureStr rangeOfString:@"&nbsp;"];
        if (range.location != NSNotFound) {
            [tureStr replaceCharactersInRange:range withString:@" "];
        }else{
            
            break;
        }
    }
    
    return tureStr;
}

/**
 *  给imgview设置类目图标
 *
 *  @param storeCateStr category
 *  @param imgview      imgView
 */
+ (void)setImageWithCategory:(NSString *)storeCateStr ContentImageView:(UIImageView *)imgview{
    if ([storeCateStr isEqualToString:@"10001001"]) {
        imgview.image=[UIImage imageNamed:@"10001001"];
    }else if ([storeCateStr isEqualToString:@"10001002"]){
        imgview.image=[UIImage imageNamed:@"10001002"];
    }else if ([storeCateStr isEqualToString:@"10001003"]){
        imgview.image=[UIImage imageNamed:@"10001003"];
    }else if ([storeCateStr isEqualToString:@"10001004"]){
        imgview.image=[UIImage imageNamed:@"10001004"];
    }else if ([storeCateStr isEqualToString:@"10001005"]){
        imgview.image=[UIImage imageNamed:@"10001005"];
    }else if ([storeCateStr isEqualToString:@"10001006"]){
        imgview.image=[UIImage imageNamed:@"10001006"];
    }else if ([storeCateStr isEqualToString:@"10001007"]||[storeCateStr isEqualToString:@"1000100405"]){
        imgview.image=[UIImage imageNamed:@"10001007"];
    }else if ([storeCateStr isEqualToString:@"10001008"]){
        imgview.image=[UIImage imageNamed:@"10001008"];
    } else {
        imgview.image=[UIImage imageNamed:@"10001001"];
    }
}

+ (UILabel *)creatLabelWithFrame:(CGRect)frame text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

+ (UIButton *)creatButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name title:(NSString *)title{
    UIButton *button = nil;
    if (name) {
        //创建图片按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        if (title) {//图片标题按钮
            [button setTitle:title forState:UIControlStateNormal];
        }
        
    }else if (title) {
        //创建标题按钮
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    button.frame = frame;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(NSString *)nsstringFormat:(NSString *)str{
    NSMutableString *yesterdayStr=[NSMutableString stringWithFormat:@"%@",str];
    if ([yesterdayStr rangeOfString:@"."].location != NSNotFound){
        NSArray *strArr=[yesterdayStr componentsSeparatedByString:@"."];
        NSRange newRange = {0,2};
        for (NSString *newStr in strArr) {
            if ([newStr length] == 0) {
                NSLog(@"空串");
                continue;
            }
        }
        if ([NSString stringWithFormat:@"%@",strArr[1]].length >=2) {
            NSString *floatStr=[strArr[1] substringWithRange:newRange];
            NSString *contentStr=[NSString stringWithFormat:@"%@.%@",strArr[0],floatStr];;
            return contentStr;
        }else{

            return [NSString stringWithFormat:@"%.2f",str.doubleValue];
        }
    }else{
       return [NSString stringWithFormat:@"%.2f",str.doubleValue];
    }
}

+(void)pushNewView:(UIViewController *)Vc pushIndex:(NSInteger)index{

    AppDelegate * delegate=[UIApplication sharedApplication].delegate;
    [delegate.myTabar removeFromSuperview];
    Vc.navigationController.navigationBar.hidden=YES;
    TabBarViewController *tabBar=[[TabBarViewController alloc]init];
    Vc.navigationController.interactivePopGestureRecognizer.enabled = NO;
    Vc.tabBarController.tabBar.hidden=YES;
    [tabBar indexBtnImage:index];
    //记录原本密码锁的值
    NSString *isCloseStr=[[NSUserDefaults standardUserDefaults]objectForKey:kIsCloseLock];
    [[NSUserDefaults standardUserDefaults]setValue:isCloseStr forKey:kIsOpenGesturePassword];
//    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:kIsCloseLock];
    [Vc.navigationController pushViewController:tabBar animated:YES];

}

+ (void)addLabelWithSuperView:(UIView *)view{
    UILabel *lblYuan = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width - 20, 5, view.frame.size.height, 20)];
    lblYuan.text = @"元";
    lblYuan.textColor = RGBA(187, 187, 187, 1.0);
    [view addSubview:lblYuan];
}

/**
 *  获取版本号
 *
 *  @return 返回版本号
 */
+ (NSString *)getVersion{
    
    NSDictionary *appInfo = [NSBundle mainBundle].infoDictionary;
    NSString *version = (NSString *)[appInfo objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (void)addInfoToRequestHeader:(AFHTTPRequestSerializer *)serializer{
//    appkey   APPKey
//    appsecret   APPSecret
//    accesstoken AccessToken
//    version     版本号
//    model       型号
//    deviceid        设备号(手机唯一标识)
//    deviceversion   设备版本(系统版本)
//    devicename      设备名(选填)
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]objectForKey:kAccessToken];
    [serializer setValue:kAppKey forHTTPHeaderField:@"appkey"];
    [serializer setValue:kAppSecret forHTTPHeaderField:@"appsecret"];
    [serializer setValue:userToken forHTTPHeaderField:@"accesstoken"];
    [serializer setValue:[self getVersion] forHTTPHeaderField:@"version"];
    [serializer setValue:[UIDeviceHardware platformString] forHTTPHeaderField:@"model"];
    [serializer setValue:[[UIDevice currentDevice].identifierForVendor UUIDString] forHTTPHeaderField:@"deviceid"];
    [serializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"deviceversion"];
    [serializer setValue:[[UIDevice currentDevice] name] forHTTPHeaderField:@"devicename"];
}

//+ (void)toPICCPage:(UIViewController *)viewController IsHideTabbar:(BOOL)hideTabbar{
//    if (hideTabbar) {
//        viewController.tabBarController.tabBar.hidden = YES;
//    }
//    StaticImageViewController *staticVc=[[StaticImageViewController alloc]init];
//    staticVc.imgName = @"三方保障.jpeg";
//    staticVc.strTitle = @"PICC";
//    [viewController.navigationController pushViewController:staticVc animated:YES];
//    
//}

/**
 *  根据城市码读取城市名
 *
 *  @param strAddressCode 城市code
 *
 *  @return 查询结果
 */
+ (NSString *)getAddressByCode:(NSString *)strAddressCode{
    NSString *strReslult = @"";
    
    NSArray *jsonArray = [[NSArray alloc]init];
    NSData *fileData = [[NSData alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"province_city_district" ofType:@"json"];
    fileData = [NSData dataWithContentsOfFile:path];
    jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary *dict in jsonArray) {
        //{"I":"320311","N":"泉山区","P":"320300"}
        if ([[dict objectForKey:@"I"] isEqualToString:strAddressCode]) {
            strReslult = [dict objectForKey:@"N"];
            break;
        }
    }
    return strReslult;
}

/**
 *  拼接地址
 *
 *  @param model 数据model
 */
//+ (NSString *)getAddressByModel:(MyWelfareModel *)model{
//    NSString *strProvince = [self getAddressByCode:model.storeprovince];
//    NSString *strCity = [self getAddressByCode:model.storecity];
//    NSString *strDistrict = [self getAddressByCode:model.storedistrict];
//    NSString *strAddress = [NSString stringWithFormat:@"%@%@%@%@",strProvince ,strCity ,strDistrict ,model.storeaddress];
//    return strAddress;
//}

+ (void)clearDataWhenLogOut{
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:kAccessToken];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:kStoreId];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kStoreId];
    [TangXSSingleton sharedInstance].isShowDistence = YES;
    //[self setShanghaiDefaultAddress];
}

+ (NSString *)getProductAmountWithString:(NSString *)strAmount{
    NSInteger amountLength = 5 - strAmount.length;
    NSString *strResultAmount = @"";
    if (amountLength > 0) {
        //此时项目金额不足10000
        switch (amountLength) {
            case 1:
                strResultAmount = [NSString stringWithFormat:@"%.1f",[strAmount integerValue]*0.0001];
                break;
            case 2:
                strResultAmount = [NSString stringWithFormat:@"%.2f",[strAmount integerValue]*0.0001];
                break;
            case 3:
                strResultAmount = [NSString stringWithFormat:@"%.3f",[strAmount integerValue]*0.0001];
                break;
            case 4:
                strResultAmount = [NSString stringWithFormat:@"%.4f",[strAmount integerValue]*0.0001];
                break;
                
            default:
                strResultAmount = [NSString stringWithFormat:@"%ld",[strAmount integerValue]/10000];
                break;
        }
    } else {
        strResultAmount = [NSString stringWithFormat:@"%ld",[strAmount integerValue]/10000];
    }
    return strResultAmount;
}

/**
 *  设置默认地址
 */
//+ (void)setDefaultAddress{
//    
//    NSDictionary *dict = [[NSUserDefaults standardUserDefaults]objectForKey:kRecentlyCityModel];
//    if (!dict) {
//        //如果没有定位信息则将上海市作为默认地址存入
//        [self setShanghaiDefaultAddress];
//    } else {
//        NSDictionary *dict = [[NSUserDefaults standardUserDefaults]objectForKey:kRecentlyCityModel];
//        [TangXSSingleton sharedInstance].latitude = [NSString stringWithFormat:@"%@",[dict objectForKey:@"W"]];
//        [TangXSSingleton sharedInstance].longitude = [NSString stringWithFormat:@"%@",[dict objectForKey:@"J"]];
//    }
//}

/**
 *  将上海作为默认地址
 */
//+ (void)setShanghaiDefaultAddress{
//    NSArray *jsonArray = [[NSArray alloc]init];
//    NSData *fileData = [[NSData alloc]init];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"shanghai_city" ofType:@"json"];
//    fileData = [NSData dataWithContentsOfFile:path];
//    jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
//    for (NSDictionary *dict in jsonArray) {
//        [[NSUserDefaults standardUserDefaults]setObject:dict forKey:kRecentlyCityModel];
//        [TangXSSingleton sharedInstance].latitude = [NSString stringWithFormat:@"%@",[dict objectForKey:@"W"]];
//        [TangXSSingleton sharedInstance].longitude = [NSString stringWithFormat:@"%@",[dict objectForKey:@"J"]];
//    }
//    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:kIsDefaultShanghai];
//}

@end
