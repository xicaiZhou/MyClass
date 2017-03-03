//
//  ViewController.m
//  下拉放大效果
//
//  Created by 周希财 on 2017/2/8.
//  Copyright © 2017年 iOS_ZXC. All rights reserved.
//

#import "ViewController.h"
#define Screen_Bounds [[UIScreen mainScreen] bounds]

#define Screen_Width CGRectGetWidth(Screen_Bounds)

#define Screen_Height CGRectGetHeight(Screen_Bounds)
#define Image_Height 250
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *image;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableView];
    [_tableView addSubview:self.image];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    if (scrollView == _tableView) {
        
        CGPoint offset = scrollView.contentOffset;
        //下拉放大实现
        NSLog(@"%f",offset.y);
        if (offset.y < 0) {
            [self setOffSetY:offset.y];
        }else{
            [self setOffSetY:0];
        }
        
    }
    
}
- (void)setOffSetY:(CGFloat)offSetY{

    CGFloat scale = Screen_Width / Image_Height;
    if (offSetY < -Image_Height) {
        CGFloat Y =  - offSetY;
        CGFloat w = Y * scale;
        _image.frame = CGRectMake( - (w - Screen_Width) / 2, -Y, w , Y );

    }
    else{
         [_tableView sendSubviewToBack:_image];
     _image.frame = CGRectMake(0, -Image_Height * (offSetY / - Image_Height),  Screen_Width, Image_Height);
    }
}
- (UIImageView *)image{
    
    if (!_image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
        imageView.frame = CGRectMake(0, -Image_Height, Screen_Width, Image_Height);
        _image = imageView;
        
    }
    return _image;
}
- (UITableView *)tableView{

    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
         [tableView setContentInset:UIEdgeInsetsMake(Image_Height, 0, 0, 0)];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"zsdfghjkl";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 100;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
