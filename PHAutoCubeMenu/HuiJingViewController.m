//
//  HuiJingViewController.m
//  HuiJing
//
//  Created by Peter on 6/20/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "HuiJingViewController.h"
#import "CubeView.h"
#import "SumCubeView.h"
#import "UIDevice+ScreenType.h"


#define screenB [UIScreen mainScreen].bounds
#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]

@interface HuiJingViewController ()<CubeTapEventDelegate>


@property(nonatomic,weak) UIScrollView *scrollV;

@property(nonatomic,strong)NSArray * titleImageArray;

@property(nonatomic,weak) UIView *moTai;

@property(nonatomic,weak)SumCubeView *sumCube;


@end

@implementation HuiJingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"惠金";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.barTintColor = color(237, 77, 38, 1);
    [self settingScrollView];
    // Do any additional setup after loading the view.
}



-(void)settingScrollView {
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, screenB.size.width, screenB.size.height - 64)];
    scrollview.backgroundColor = color(241, 242, 243, 1);
    
    scrollview.contentSize = CGSizeMake(0, 600);
    scrollview.showsVerticalScrollIndicator = NO;

    
    self.scrollV = scrollview;
    [self.view addSubview:scrollview];
    [self setConponent];
   
    
}



-(NSArray *)titleImageArray {
    NSMutableArray *titleimagearray = [NSMutableArray array];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"CubeMenu" ofType:@"plist"];
    titleimagearray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    _titleImageArray = titleimagearray;
    return _titleImageArray;
}



-(void)setConponent {
    
//    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(10, -54, screenB.size.width - 20, 100)];
//    header.backgroundColor = [UIColor blueColor];
    
    UIView *middle = [[UIView alloc] initWithFrame:CGRectMake(0, 56, screenB.size.width, 80)];
    middle.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button1.bounds = CGRectMake(0, 0, 44, 44);
    button2.bounds = CGRectMake(0, 0, 44, 44);
    button3.bounds = CGRectMake(0, 0, 44, 44);
    
    button1.center = CGPointMake(screenB.size.width / 6, 30);
    button2.center = CGPointMake(screenB.size.width / 6 * 3, 30);
    button3.center = CGPointMake(screenB.size.width / 6 * 5, 30);


    [button1 setImage:[UIImage imageNamed: @"HJ_tougu"] forState:UIControlStateNormal];

    [button2 setImage:[UIImage imageNamed: @"HJ_daniu"] forState:UIControlStateNormal];
    
    [button3 setImage:[UIImage imageNamed: @"HJ_daniu"] forState:UIControlStateNormal];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    UILabel *label2 = [[UILabel alloc] init];
    UILabel *label3 = [[UILabel alloc] init];
    
    label1.text = @"1";
    label2.text = @"2";
    label3.text = @"3";
    
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    label3.textAlignment = NSTextAlignmentCenter;
    
    label1.bounds = CGRectMake(0, 0, 100, 20);
    label2.bounds = CGRectMake(0, 0, 100, 20);
    label3.bounds = CGRectMake(0, 0, 100, 20);
    
    label1.center = CGPointMake(screenB.size.width / 6, 65);
    label2.center = CGPointMake(screenB.size.width / 6 * 3, 65);
    label3.center = CGPointMake(screenB.size.width / 6 * 5, 65);
    
    label1.font = [UIFont systemFontOfSize:13];
    label2.font = [UIFont systemFontOfSize:13];
    label3.font = [UIFont systemFontOfSize:13];
    
    
    UIView *fenge1 = [[UIView alloc] initWithFrame:CGRectMake(screenB.size.width / 3, 10, 0.5, 63)];
    UIView *fenge2 = [[UIView alloc] initWithFrame:CGRectMake(screenB.size.width / 3 * 2, 10, 0.5, 63)];
    fenge1.backgroundColor = color(200, 200, 200, 1);
    fenge2.backgroundColor = color(200, 200, 200, 1);

    
    [middle addSubview:button1];
    [middle addSubview:button2];
    [middle addSubview:button3];

    
    [middle addSubview:label1];
    [middle addSubview:label2];
    [middle addSubview:label3];

    
    [middle addSubview:fenge1];
    [middle addSubview:fenge2];
    
CGFloat cubepadding = 1;
CGFloat cubewidth = (screenB.size.width - 2 * cubepadding) / 3;

    

    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
        
            CubeView *cube = [self cubeViewMakerWith:CGRectMake(j *(cubewidth + cubepadding), 146 + i * (cubewidth + cubepadding),cubewidth , cubewidth) title: self.titleImageArray[0][i * 3 + j] andImageName:self.titleImageArray[1][i * 3 + j]];
            [self.scrollV addSubview:cube];
            cube.tag = i * 3 + j + 10;
            cube.isRDragble = NO;
            cube.delegate2 = self;
        }
    }
    
    
//    [self.scrollV addSubview:header];
    [self.scrollV addSubview:middle];
}


-(CubeView *)cubeViewMakerWith:(CGRect)rect title:(NSString *)title  andImageName:(NSString *)name {
    
    CubeView *cube = [CubeView instanceCubeView];
    cube.frame = rect;
    [cube setTitle:title andImageName:name];
    
    return cube;
}


-(void)showMoTaiView {
    UIView *motai = [[UIView alloc] init];
    motai.center = CGPointMake(0.5 * screenB.size.width, 0.5 * screenB.size.height);
    motai.bounds = CGRectMake(0, 0, screenB.size.width * 0.1, screenB.size.height * 0.1);
    motai.alpha = 0;
    motai.backgroundColor = [UIColor blackColor];
    _moTai = motai;
    [self.view addSubview:motai];
    
    [UIView animateWithDuration:0.3 animations:^{
        _moTai.alpha = 0.8;
        _moTai.frame = CGRectMake(0, 0, screenB.size.width, screenB.size.height);
    } completion:^(BOOL finished) {
        [self setMoTaiViewConponent];
    }];
}


-(void)setMoTaiViewConponent {
    SumCubeView *sumcube = [[SumCubeView alloc] init];
    
    sumcube.titleImageArray = self.titleImageArray;
    sumcube.alpha = 0;
    [self.view addSubview:sumcube];
    
    _sumCube = sumcube;
    
    UIButton *okbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    okbutton.bounds = CGRectMake(0, 0, 10, 10);
    okbutton.backgroundColor = [UIColor redColor];
    okbutton.alpha = 0;
    okbutton.layer.cornerRadius = 4;
    [okbutton setTitle:@"完成" forState:UIControlStateNormal];
    [okbutton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:okbutton];
        [okbutton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    switch ([UIDevice getScreenType]) {
        case ScreenType320x480:
            sumcube.frame = CGRectMake(0, 30, screenB.size.width, screenB.size.width);
            okbutton.center = CGPointMake(screenB.size.width / 2, 70 + screenB.size.width);
            break;
        case ScreenType320x568:
            sumcube.frame = CGRectMake(0, 78, screenB.size.width, screenB.size.width);
            okbutton.center = CGPointMake(screenB.size.width / 2, 130 + screenB.size.width);
            break;
        case ScreenType375x667:
            sumcube.frame = CGRectMake(0, 100, screenB.size.width, screenB.size.width);
            okbutton.center = CGPointMake(screenB.size.width / 2, 155 + screenB.size.width);
            break;
        case ScreenType414x736:
            sumcube.frame = CGRectMake(0, 120, screenB.size.width, screenB.size.width);
            okbutton.center = CGPointMake(screenB.size.width / 2, 180 + screenB.size.width);
            break;
        default:
            break;
    }

    
    
    
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseOut animations:^{
        okbutton.alpha = 1;
        sumcube.alpha = 1;
        okbutton.bounds = CGRectMake(0, 0, 100, 40);
    } completion:^(BOOL finished) {
        [sumcube setCubeView];
    }];
    

}


-(void)okButtonClick:(id)sender {
    [_sumCube saveChangeToPlist];
    [self resetCubeView];
    [sender removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        _sumCube.alpha = 0;
        _moTai.alpha = 0;
       
    } completion:^(BOOL finished) {
        [_sumCube removeFromSuperview];
        [_moTai removeFromSuperview];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)resetCubeView {
    for (int i = 0 ; i < 9; i++) {
        CubeView *cube = [self.scrollV viewWithTag:(i + 10)];
        [cube setTitle:self.titleImageArray[0][i] andImageName:self.titleImageArray[1][i]];
    }
}



#pragma mark - tap event delegate

-(void)longPressEvent:(CubeView *)cube {
    
    NSLog(@"longpress");
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"the height is %f",height);
    [self showMoTaiView];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
