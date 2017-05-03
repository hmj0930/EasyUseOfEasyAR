//
//  ARViewController.m
//  EasyUseOfEasyAR
//
//  Created by MJ on 2017/5/2.
//  Copyright © 2017年 韩明静. All rights reserved.
//

#import "ARViewController.h"
#import "OpenGLView.h"
#import "AppDelegate.h"

@interface ARViewController ()

@property(nonatomic,strong)UIImageView *image;

@property(nonatomic, strong) OpenGLView *glView;


@end

@implementation ARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.glView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.glView];
    self.image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123"]];
    self.image.bounds=CGRectMake(0, 0, 300, 300);
    self.image.center=self.view.center;
    self.image.hidden=YES;
    [self.view addSubview:self.image];
    
    [self.glView setOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(abc) name:@"arSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(abcabc) name:@"arFail" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ((AppDelegate *)[[UIApplication sharedApplication]delegate]).active=YES;
    [self.glView start];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    ((AppDelegate *)[[UIApplication sharedApplication]delegate]).active=NO;
    [self.glView stop];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.glView resize:self.view.bounds orientation:self.interfaceOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.glView setOrientation:toInterfaceOrientation];
}

-(void)abc{
    
    
    self.image.hidden=NO;
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
}

-(void)dismiss{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)abcabc{
    
    //    NSLog(@"123");
    self.image.hidden=YES;
}



@end
