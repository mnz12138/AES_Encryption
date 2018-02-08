//
//  ViewController.m
//  AES加密
//
//  Created by 王全金 on 2018/1/31.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "ViewController.h"
#import "NSString+AES.h"

#define XOR_KEY 0xBB
//XOR_KEY并不是只能是0XBB,0XAA、0X22、0X11等十六进制数都可以的。

@interface ViewController ()

@end

@implementation ViewController

void xorString(unsigned char *str, unsigned char key) {
    unsigned char *p = str;
    while( ((*p) ^=  key) != '\0')  p++;
}

//对于字符串加解密，常规的方法就是进行异或加解密。
- (NSString *)new_key {
    unsigned char str[] = {
        (XOR_KEY ^ '0'),
        (XOR_KEY ^ '1'),
        (XOR_KEY ^ '2'),
        (XOR_KEY ^ '3'),
        (XOR_KEY ^ '4'),
        (XOR_KEY ^ '5'),
        (XOR_KEY ^ '6'),
        (XOR_KEY ^ '7'),
        (XOR_KEY ^ '8'),
        (XOR_KEY ^ '9'),
        (XOR_KEY ^ '1'),
        (XOR_KEY ^ '2'),
        (XOR_KEY ^ '3'),
        (XOR_KEY ^ '4'),
        (XOR_KEY ^ '5'),
        (XOR_KEY ^ '6'),
        (XOR_KEY ^ '\0')
    };
    xorString(str, XOR_KEY);
    unsigned long len = sizeof(str);
    unsigned char result[len];
    memcpy(result, str, len);
    return [NSString stringWithFormat:@"%s",result];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *content = @"我是需要加密的内容";
    NSString *key = [self new_key];
    NSString *result = [NSString encryptAES:content key:key];
    NSString *text = [NSString decryptAES:result key:key];
    NSLog(@"key:%@",key);
    NSLog(@"加密前:%@",content);
    NSLog(@"加密后:%@",result);
    NSLog(@"解密后:%@",text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
