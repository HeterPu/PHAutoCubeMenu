//
//  CubeView.m
//  HuiJing
//
//  Created by Peter on 6/20/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "CubeView.h"

@interface CubeView()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (nonatomic,assign)CGPoint startPoint;



@end

@implementation CubeView


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        UITapGestureRecognizer *singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cubeViewSingleClick)];
        singletap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singletap];
        
        UITapGestureRecognizer *doubletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cubeViewDoubleClick)];
        singletap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubletap];
        
        UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longpress.minimumPressDuration = 1.0;
        [self addGestureRecognizer:longpress];
    }
    return self;
}




+(CubeView *)instanceCubeView {
    
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"CubeView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}



-(void)setTitle:(NSString *)title andImageName:(NSString *)name {
    
    _nameL.text = title;
    _imageV.image = [UIImage imageNamed:name];
    _iconName = name;
    _labelName = title;
}



-(void)cubeViewClick {
    NSLog(@"1231234");
}


#pragma mark - Tap Event Delegate

-(void)longPress:(UILongPressGestureRecognizer *)sender {
//    [UIView animateWithDuration:0.5 animations:^{
//        
//    }];
    
    
//    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseOut  animations:^{
//        self.transform =  CGAffineTransformMakeScale(0.9, 0.9);
//    } completion:^(BOOL finished) {
//        
//    }];
    if(sender.state == UIGestureRecognizerStateBegan){
    
    if ([self.delegate2 respondsToSelector:@selector(longPressEvent:)]) {
        [self.delegate2 longPressEvent:self];
    }
        
  }
}



-(void)cubeViewSingleClick {
    
    if ([self.delegate2 respondsToSelector:@selector(singleTapEvent:)]) {
        [self.delegate2 singleTapEvent:self];
    }
}



-(void)cubeViewDoubleClick {
    
    if ([self.delegate2 respondsToSelector:@selector(doubleTapEvent:)]) {
        [self.delegate2 doubleTapEvent:self];
    }
}



//触摸事件
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //保存触摸起始点位置
    CGPoint point = [[touches anyObject] locationInView:self];
    _startPoint = point;
    
    //该view置于最前
    [[self superview] bringSubviewToFront:self];
    
    //相对于父视图的位置
    CGPoint superpoint = [[touches anyObject] locationInView:self.superview];
    if ([self.delegate1 respondsToSelector:@selector(cubeTouchBeganWith:andPosition:)]) {
        [self.delegate1 cubeTouchBeganWith:self andPosition:superpoint];
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (_isRDragble == YES) {
        
   
    //计算位移=当前位置-起始位置
    CGPoint point = [[touches anyObject] locationInView:self];
    float dx = point.x - _startPoint.x;
    float dy = point.y - _startPoint.y;
    
    //计算移动后的view中心点
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    
    
    /* 限制用户不可将视图托出屏幕 */
    float halfx = CGRectGetMidX(self.bounds);
    //x坐标左边界
    newcenter.x = MAX(halfx, newcenter.x);
    //x坐标右边界
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    //y坐标同理
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
   
        //移动view
    self.center = newcenter;
    

    NSLog(@"horizon%f",newcenter.x);
    NSLog(@"vertical%f",newcenter.y);
    if ([self.delegate1 respondsToSelector:@selector(cubeTouchMoveWith:andPosition:)]) {
        [self.delegate1 cubeTouchMoveWith:self andPosition:newcenter];
    }
        
    };
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //保存触摸起始点位置
    CGPoint point = [[touches anyObject] locationInView:self.superview];
    
    if ([self.delegate1 respondsToSelector:@selector(cubeTouchEndWith:andPosition:)]) {
        [self.delegate1 cubeTouchEndWith:self andPosition:point];
    }
}


-(void)setShrinkAnimated {
    [UIView animateWithDuration:0.6 delay:0.4 usingSpringWithDamping:0.2 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseOut  animations:^{
        self.transform =  CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        
    }];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
