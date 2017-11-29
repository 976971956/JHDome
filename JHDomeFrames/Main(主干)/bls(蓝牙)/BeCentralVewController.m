//
//  BeCentraliewController.m
//  BleDemo
//
//  Created by ZTELiuyw on 15/9/7.
//  Copyright (c) 2015年 liuyanwei. All rights reserved.
//

#import "BeCentralVewController.h"
#import "WaibuViewController.h"

static NSString *const ServiceUUID1 =  @"FFF0";
static NSString *const notiyCharacteristicUUID =  @"FFF1";
static NSString *const readwriteCharacteristicUUID =  @"FFF2";
static NSString *const ServiceUUID2 =  @"FFE0";
static NSString *const readCharacteristicUUID =  @"FFE1";
static NSString * const LocalNameKey =  @"myPeripheral";

#define ShowMessage(MESSAGE,QUVC) \
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:MESSAGE preferredStyle:UIAlertControllerStyleAlert]; \
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]; \
[alertController addAction:okAction]; \
[QUVC presentViewController:alertController animated:YES completion:nil];

@interface BeCentralVewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //系统蓝牙设备管理对象，可以把他理解为主设备，通过他，可以去扫描和链接外设
    CBCentralManager *manager;
    UILabel *info;
    //用于保存被发现设备
    NSMutableArray *discoverPeripherals;
    UITableView *MyTableView;
}
@property(nonatomic,strong)CBPeripheral *Myperipheral;
@property (strong ,nonatomic) CBCharacteristic *writeCharacteristic;

@end

@implementation BeCentralVewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索到的设备";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    /*
     设置主设备的委托,CBCentralManagerDelegate
     必须实现的：
     - (void)centralManagerDidUpdateState:(CBCentralManager *)central;//主设备状态改变的委托，在初始化CBCentralManager的适合会打开设备，只有当设备正确打开后才能使用
     其他选择实现的委托中比较重要的：
     - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设的委托
     - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
     - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
     - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
     */
    
    //初始化并设置委托和线程队列，最好一个线程的参数可以为nil，默认会就main线程
    manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
  //持有发现的设备,如果不持有设备会导致CBPeripheralDelegate方法不能正确回调
    discoverPeripherals = [[NSMutableArray alloc]init];
    //页面样式
    [self.view setBackgroundColor:[UIColor whiteColor]];
    info = [[UILabel alloc]initWithFrame:self.view.frame];
    [info setText:@"正在执行程序，请观察NSLog信息"];
    [info setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:info];
    
    MyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    MyTableView.delegate = self;
    MyTableView.dataSource = self;
    [self.view addSubview:MyTableView];
    [MyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(void)send
{
    Byte dataArr[3];
    
    dataArr[0]=0xf; dataArr[1]=0xbb;dataArr[2]=0xbb;
    NSString *str = [NSString stringWithFormat:@"我是中心设备%d，外部设备你好啊",rand()%101];
    NSData * myData = [str dataUsingEncoding:NSUTF8StringEncoding];

    [self writeCharacteristic:_Myperipheral characteristic:_writeCharacteristic value:myData];
    [_Myperipheral readValueForCharacteristic:_writeCharacteristic];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return discoverPeripherals.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    CBPeripheral *peripheral = discoverPeripherals[indexPath.row];
    cell.textLabel.text = peripheral.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    停止扫描外设
    [manager stopScan];

    CBPeripheral *peripheral = discoverPeripherals[indexPath.row];
//3.点击开始连接设备，假设连接成功了，会回调其代理方法centralManager:didConnectPeripheral:
    [manager connectPeripheral:peripheral options:nil];
    
    WaibuViewController *vc = [[WaibuViewController alloc]init];
    vc.datas = discoverPeripherals;
    vc.row = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}
//你必须实现这个代理方法来确定中心设备是否支持BLE以及是否可用。
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>未知的");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>重复的");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>不支持蓝牙");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>蓝牙未授权的");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>蓝牙处于关闭状态");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>蓝牙已打开");
            //1.开始扫描周围的外设
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            NSLog(@"%@",ServiceUUID1);
            [central scanForPeripheralsWithServices:nil options:nil];
            
            break;
        default:
            break;
    }
    
}

//2.扫描到的每个设备都会进入方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"扫描到的设备:%@",peripheral.name);
    //接下连接我们的测试设备，如果你没有设备，可以下载一个app叫lightbule的app去模拟一个设备
    //这里自己去设置下连接规则，我设置的是P开头的设备
//    if ([peripheral.name hasPrefix:@"P"]){
        /*
         一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的委托
         - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
         - (void)centra`lManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
         - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
         */
  
        //找到的设备必须持有它，否则CBCentralManager中也不会保存peripheral，那么CBPeripheralDelegate中的方法也不会被调用！！

    if (![discoverPeripherals containsObject:peripheral]) {
//        添加搜索到的新设备
        [discoverPeripherals addObject:peripheral];
//        刷新列表显示设备列表
        [MyTableView reloadData];
    }
        //    }
    
    
}


//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}
//-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
//{
//    peripheral.delegate = self;
//    [self.Myperipheral discoverServices:@[[CBUUID UUIDWithString:@"A65eBB2D-3D30-4981-9DB2-1996D88118A0"]]];
//}
//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    peripheral.delegate = self;

    NSString *content =[NSString stringWithFormat:@"外部设备%@连接断开，error：%@",peripheral.name,error.localizedDescription];
    NSLog(@"%@",error.localizedDescription);
//    ShowMessage(content, self)
    //设置重新连接
    [central connectPeripheral:peripheral options:nil];

    
}
//4.连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSString *content =[NSString stringWithFormat:@"外部设备%@连接成功",peripheral.name];
//    ShowMessage(content, self);
    //设置的peripheral委托CBPeripheralDelegate
    //@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
    peripheral.delegate = self;
    self.Myperipheral = peripheral;
    NSLog(@"%@",peripheral.identifier.UUIDString);
    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
//    扫描外设中所有的服务
    [peripheral discoverServices:nil];
//    停止扫描

}


//5.扫描到Services
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error)
    {
        NSLog(@">>> 外设的名称 ： %@  错误信息 : %@", peripheral.name, [error localizedDescription]);
        return;
    }
//   获取 存储外设的每一个服务
    for (CBService *service in peripheral.services) {
        NSLog(@"外设的服务UUID:%@",service.UUID);
        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        if ([service.UUID isEqual:[CBUUID UUIDWithString:ServiceUUID1]]) {

        }
        [peripheral discoverCharacteristics:nil forService:service];

    }

}

//6.扫描到Characteristics
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error)
    {
        NSLog(@"服务的UUID %@ 错误信息: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"服务的UUID:%@ 的 服务下的特征: %@",service.UUID.UUIDString,characteristic.UUID.UUIDString);
        //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
        [peripheral readValueForCharacteristic:characteristic];
        //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
        [peripheral discoverDescriptorsForCharacteristic:characteristic];

    }
}

//获取的charateristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //打印出characteristic的UUID和值
    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"特征 uuid:%@  value:%@",characteristic.UUID,characteristic.value);
    
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    
    
    if (error) {
        
        NSLog(@"Error changing notification state: %@",
              
              [error localizedDescription]);
        
    }
}
//搜索到Characteristic的Descriptors
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //打印出Characteristic和他的Descriptors
    NSLog(@"特征 uuid:%@",characteristic);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]) {
        _writeCharacteristic = characteristic;
    }
    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"特征描述 uuid:%@",d.UUID.UUIDString);
    }
    
}
//获取到Descriptors的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"描述 uuid:%@  value:%@",descriptor.UUID.UUIDString,descriptor.value);
}

//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{
    
    //打印出 characteristic 的权限，可以看到有很多种，这是一个NS_OPTIONS，就是可以同时用于好几个值，常见的有read，write，notify，indicate，知知道这几个基本就够用了，前连个是读写权限，后两个都是通知，两种不同的通知方式。
    /*
     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
     CBCharacteristicPropertyBroadcast												= 0x01,
     CBCharacteristicPropertyRead													= 0x02,
     CBCharacteristicPropertyWriteWithoutResponse									= 0x04,
     CBCharacteristicPropertyWrite													= 0x08,
     CBCharacteristicPropertyNotify													= 0x10,
     CBCharacteristicPropertyIndicate												= 0x20,
     CBCharacteristicPropertyAuthenticatedSignedWrites								= 0x40,
     CBCharacteristicPropertyExtendedProperties										= 0x80,
     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)		= 0x100,
     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)	= 0x200
     };
     
     */
    NSLog(@"写数据：%lu", (unsigned long)characteristic.properties);
    
    
    //只有 characteristic.properties 有write的权限才可以写
    if(characteristic.properties & CBCharacteristicPropertyWrite){
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
         */
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        
        
    }else{
        NSLog(@"该字段不可写！");
    }
    
    
}

//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

//停止扫描并断开连接
-(void)disconnectPeripheral:(CBCentralManager *)centralManager
                 peripheral:(CBPeripheral *)peripheral{
    NSLog(@"停止扫描");
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"error:%@",error.localizedDescription);
    }
    NSLog(@"写入成功");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
