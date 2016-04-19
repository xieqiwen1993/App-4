//
//  MapViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/12.
//  Copyright © 2016年 company. All rights reserved.
//

#import "MapViewController.h"
#import "SuccesViewController.h"
#import "FailedViewController.h"

@interface MapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService* _locService;
}
@property(nonatomic,strong)BMKMapView * mapView;
@property (nonatomic) CLLocationCoordinate2D coordinate;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"申请单";
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 68, kScreenWidth,250 )];
    [self.view addSubview:_mapView];
        // 添加一个PointAnnotation
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    _coordinate.latitude=30.6405540000;
//    _coordinate.longitude=104.1038520000;
//    annotation.coordinate = _coordinate;
//    annotation.title = @"顺江新苑";
//    [_mapView addAnnotation:annotation];
//    
//    [_mapView selectAnnotation:annotation animated:YES];
//    
//        //将百度地图中心点定位到当前商户位置
//        BMKCoordinateRegion region ;//表示范围的结构体
//        region.center = _coordinate;//中心点
//        region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
//        region.span.longitudeDelta = 0.1;//纬度范围
//        [_mapView setRegion:region animated:YES];

    //定位
   _locService = [[BMKLocationService alloc]init];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;

    //启动LocationService
    [_locService startUserLocationService];

    // Do any additional setup after loading the view from its nib.
}
//自定义精度圈
- (void)customLocationAccuracyCircle {
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    param.accuracyCircleStrokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    param.accuracyCircleFillColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.3];
    [_mapView updateLocationViewWithParam:param];
}
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //userLocation.title=@"环球中心w1";
    [_mapView updateLocationData:userLocation];
}



- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSLog(@"viewForAnnotation");
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}


-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitClick:(id)sender {
    //SuccesViewController *vc=[[SuccesViewController alloc]init];
    FailedViewController *vc=[[FailedViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
