//
//  MMViewController.m
//  MMSpinImageView
//
//  Created by Ralph Li on 12/30/13.
//  Copyright (c) 2013 LJC. All rights reserved.
//

#import "MMViewController.h"
#import "MMSpinImageView.h"

@interface MMViewController ()

@property (nonatomic, strong) MMSpinImageView *imageView;
@property (nonatomic, strong) UIButton *btnMemo;
@property (nonatomic, strong) UIButton *btnFile;

@end

@implementation MMViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.imageView = [[MMSpinImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        [self.view addSubview:self.imageView];
        
        self.btnMemo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btnMemo.layer.borderWidth = 1.0f;
        self.btnMemo.frame = CGRectMake(20, 320, 130, 50);
        [self.btnMemo setTitle:@"load images" forState:UIControlStateNormal];
        [self.btnMemo setBackgroundColor:[UIColor whiteColor]];
        [self.btnMemo addTarget:self action:@selector(actionMemo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.btnMemo];
        
        self.btnFile = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btnFile.layer.borderWidth = 1.0f;
        self.btnFile.frame = CGRectMake(170, 320, 130, 50);
        [self.btnFile setTitle:@"load zip file" forState:UIControlStateNormal];
        [self.btnFile setBackgroundColor:[UIColor whiteColor]];
        [self.btnFile addTarget:self action:@selector(actionFile) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.btnFile];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) actionMemo
{
    self.imageView.imagesArray = @[
                                   [UIImage imageNamed:@"01.png"],
                                   [UIImage imageNamed:@"02.png"],
                                   [UIImage imageNamed:@"03.png"],
                                   [UIImage imageNamed:@"04.png"],
                                   [UIImage imageNamed:@"05.png"]
                                   ];
}

- (void) actionFile
{
    NSLog(@"%@",[[NSBundle mainBundle].resourceURL.path stringByAppendingString:@"/car.zip"]);
    [self.imageView loadDataFromZip:[[NSBundle mainBundle].resourceURL.path stringByAppendingString:@"/car.zip"]];
}

@end
