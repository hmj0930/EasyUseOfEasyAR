//
//  ViewController.m
//  EasyAREasyUse
//
//  Created by MJ on 2017/5/3.
//  Copyright © 2017年 韩明静. All rights reserved.
//

#import "ViewController.h"
#import "ARViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UIButton *button;

@property(nonatomic,strong)UIImageView *imageview;

@property(nonatomic,strong)UIButton *arButton;

@end

@implementation ViewController

-(UIButton *)button{
    
    if (_button==nil) {
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"下载网络图片" forState:UIControlStateNormal];
        _button.backgroundColor=[UIColor blueColor];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)buttonAction{
    
    [self createDirectory];
    [self createFile];
}

-(UIImageView *)imageview{
    
    if (_imageview==nil) {
        _imageview=[UIImageView new];
    }
    return _imageview;
}

-(UIButton *)arButton{
    
    if (_arButton==nil) {
        _arButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_arButton setTitle:@"去扫描" forState:UIControlStateNormal];
        _arButton.backgroundColor=[UIColor orangeColor];
        [_arButton addTarget:self action:@selector(arButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arButton;
}

-(void)arButtonAction{
    
    ARViewController *vc=[ARViewController new];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button.frame=CGRectMake(20, 100, 130, 50);
    [self.view addSubview:self.button];
    
    self.arButton.frame=CGRectMake(150, 100, 130, 50);
    [self.view addSubview:self.arButton];
    
    self.imageview.frame=CGRectMake(100, 250, 200, 200);
    [self.view addSubview:self.imageview];
}

//获取Documents路径
-(NSString *)getDocumentsPath{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    return path;
}

//创建文件夹
-(void)createDirectory{
    
    NSString *documentsPath=[self getDocumentsPath];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *iosDirectory=[documentsPath stringByAppendingPathComponent:@"ios"];
    
    BOOL isSuccess=[fileManager createDirectoryAtPath:iosDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (isSuccess) {
        NSLog(@"创建成功");
    }else{
        
        NSLog(@"创建失败");
    }
}

//创建文件
-(void)createFile{
    //获取Documents路径
    //创建文件夹路径
    //创建图片路径，并把图片命名为ios.jpg
    NSString *documentsPath=[self getDocumentsPath];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *iosDirectory=[documentsPath stringByAppendingPathComponent:@"ios"];
    NSString *iosPath=[iosDirectory stringByAppendingPathComponent:@"ios.jpg"];
    //把图片的路径保存在本地
    [[NSUserDefaults standardUserDefaults]setObject:iosPath forKey:@"path"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //把图片写入文件
    NSURL *url=[NSURL URLWithString:@"http://esports.net.cn:6323/QileEn/files/headImage[1].png"];
    NSData *content=UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:url]], .0000005);
    BOOL isSuccess=[fileManager createFileAtPath:iosPath contents:nil attributes:nil];
    if (isSuccess) {
        NSLog(@"创建成功");
    }else{
        
        NSLog(@"创建失败");
    }
    [content writeToFile:iosPath atomically:YES];
    //给self.imageview设置图片
    NSData *data=[NSData dataWithContentsOfURL:url];
    self.imageview.image=[UIImage imageWithData:data];
    
    
}


@end
