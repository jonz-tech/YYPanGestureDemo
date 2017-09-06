//
//  ViewController.m
//  YYPanGestureDemo
//
//  Created by zhuangchubin on 2017/9/1.
//  Copyright © 2017年 zhuangchubin. All rights reserved.
//

#import "ViewController.h"
#import "YYPanGestureModule.h"
#import "ZipArchive.h"

@interface ViewController ()
{
    YYPanGestureModule *panModule;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    panModule = [YYPanGestureModule addPanGestureInView:self.view];
    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(unZipFile) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor redColor];
//    [self unZipFile];
}

- (void)unZipFile{
    ZipArchive *zip = [[ZipArchive alloc] init];
    NSString *tileDirectory = [[[NSBundle mainBundle] resourcePath]
                               stringByAppendingPathComponent:@"xibeihanzi.zip"];
    BOOL result     = [zip UnzipOpenFile:tileDirectory];
    if (result) {
        NSString *outputPath = [[ViewController stickerDirectory] stringByAppendingString:@"/xibeihanzi"];
        BOOL isSuccess  = [zip UnzipFileTo:outputPath overWrite:YES];
        NSLog(@"is success %d path %@",isSuccess,outputPath);
    }else {
        NSLog(@"fail %d ", result);
    }
}


+ (NSString *)stickerDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *stickerDirectory = [documentsDirectory stringByAppendingPathComponent:@"TinyVideoEmoticon"];
    BOOL isDir;
    if ([fileManager fileExistsAtPath:stickerDirectory isDirectory:&isDir] && isDir) {
        return stickerDirectory;
    } else {
        [fileManager createDirectoryAtPath:stickerDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return stickerDirectory;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
