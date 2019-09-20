//
//  ViewController.m
//  GetPhoneIPAddressDemo
//
//  Created by HaoHuoBan on 2019/9/20.
//  Copyright © 2019年 HaoHuoBan. All rights reserved.
//

#import "ViewController.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getIPAddressTest];
}

- (void)getIPAddressTest {
    // 注意需要倒入头文件！
    NSString *address = @"error";
    struct ifaddrs * ifaddress = NULL;
    struct ifaddrs * temp_address = NULL;
    int success = 0;
    success = getifaddrs(&ifaddress);
    if(success == 0) {
        temp_address = ifaddress;
        while(temp_address != NULL) {
            if(temp_address->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_address->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_address->ifa_addr)->sin_addr)];
                }
            }
            temp_address = temp_address->ifa_next;
        }
    }
    
    
    NSLog(@"获取到的IP地址为：%@",address);
}



@end
