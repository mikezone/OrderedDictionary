//
//  ViewController.m
//  OrderedDictionary
//
//  Created by Mike on 16/4/21.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "ViewController.h"
#import "JSONKit.h"
#import "OrderedDictionary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OrderedDictionary *dict = [OrderedDictionary dictionary];
    dict[@"key1"] = @(10);
    dict[@"key2"] = @(11);
    NSLog(@"%@", dict[@"key1"]);
    NSLog(@"%zd", dict.count);
    NSLog(@"%@", dict.allKeys);
    NSLog(@"%@", dict.allValues);
    [dict setObject:@(12) forKey:@"key3"];
    NSLog(@"%@", dict);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    JSONDecoder *decoder = [[JSONDecoder alloc] init];
    id value = [decoder objectWithData:data error:NULL];
    NSLog(@"%@", value);
}


@end
