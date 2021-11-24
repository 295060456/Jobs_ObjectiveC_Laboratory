//
//  FVC.m
//  Search
//
//  Created by Jobs on 2020/8/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "FVC.h"

@interface FVC ()

@end

@implementation FVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    1  // 将 NSData 类型对象 data 写入文件, 文件名为 FileName
//    2  [data writeToFile:FileName atomically:YES];
//    3  // 从 FileName 中读取出数据
//    4  NSData  *data=[NSData dataWithContentsOfFile:FileName options:0 error:NULL];
    
    NSURL *sampleURL = [[NSBundle mainBundle] URLForResource:@"KKK" withExtension:@"mp4" subdirectory:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:sampleURL];
    
    NSString *d = video_file_url(@"见哥");
//    /var/mobile/Containers/Data/Application/18560ED1-9D03-440D-ADDE-9E67BD9BD918/Documents/VideoJobs/见哥.mp4
    
    [data writeToFile:d atomically:YES];
    
    
//
//
//
    NSData *dd = NSData.data;
    dd = [NSFileManager.defaultManager contentsAtPath:d];
//
    NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:d];
    NSData *dataq = [fh readDataToEndOfFile];
//
//
    NSLog(@"");
    
//    if (![[NSFileManager defaultManager]fileExistsAtPath:video_file_url(@"test")]) {
    
    
}

NSString *video_file_url(NSString *file){
    NSString * videoPath =  [file stringByAppendingString:@".mp4"];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"VideoJobs"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //创建目录
       BOOL isSuccess =  [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (isSuccess) {
            videoPath = [path stringByAppendingPathComponent:videoPath];
        }else
            videoPath = nil;
    }else
        videoPath = [path stringByAppendingPathComponent:videoPath];
    return videoPath;
}






@end
