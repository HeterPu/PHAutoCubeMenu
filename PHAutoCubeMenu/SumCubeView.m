//
//  SumCubeView.m
//  HuiJing
//
//  Created by Peter on 6/21/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "SumCubeView.h"
#import "CubeView.h"

@interface SumCubeView()<CubeTouchEventDelegate>

@property(nonatomic,weak)CubeView *selectedCube;
@property(nonatomic,assign)NSInteger from;
@property(nonatomic,assign)NSInteger to;

@property(nonatomic,strong)NSMutableArray *cubeViewArray;


@end


@implementation SumCubeView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        
    }
    return self;
}



-(NSArray *)titleImageArray {
    NSMutableArray *titleimagearray = [NSMutableArray array];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"CubeMenu" ofType:@"plist"];
    titleimagearray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    _titleImageArray = titleimagearray;
    return _titleImageArray;
}



-(void)setCubeView {

    CGFloat cubepadding = 1;
    CGFloat cubewidth = (self.frame.size.width - 2 * cubepadding) / 3;
    _cubeViewArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            
            CubeView *cube = [self cubeViewMakerWith:CGRectMake(j *(cubewidth + cubepadding), i * (cubewidth + cubepadding),cubewidth , cubewidth) title: self.titleImageArray[0][i * 3 + j] andImageName:self.titleImageArray[1][i * 3 + j]];
            cube.tag = i * 3 + j + 1;
            [self addSubview:cube];
            [cube setShrinkAnimated];
            cube.delegate1 = self;
            cube.isRDragble = YES;
            [_cubeViewArray addObject:cube];
        }
    }
}



-(CubeView *)cubeViewMakerWith:(CGRect)rect title:(NSString *)title  andImageName:(NSString *)name {
    
    CubeView *cube = [CubeView instanceCubeView];
    cube.frame = rect;
    [cube setTitle:title andImageName:name];
    
    return cube;
}



-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"move began");
    
}


#pragma mark - CubeViewClickDelegate

-(void)cubeTouchBeganWith:(CubeView *)cube andPosition:(CGPoint)point {
    
    NSLog(@"the cube touch began tag is %li and the touch positon is x = %f,y = %f",(long)cube.tag,point.x,point.y);
    
    
}

-(void)cubeTouchMoveWith:(CubeView *)cube andPosition:(CGPoint)point {
    
    NSLog(@"the cube move tag is %li and the touch positon is x = %f,y = %f",(long)cube.tag,point.x,point.y);
    NSInteger  from = cube.tag - 1;
    NSInteger  to = [self cheakMovePointArea:point];
    _from = from;
    _to = to;
    
    _selectedCube = cube;
    
    if (from != to) {
        [self setNewTagByCubeMovingFrom:from to:to];
    }


}


-(void)cubeTouchEndWith:(CubeView *)cube andPosition:(CGPoint)point {
    
    _selectedCube.tag = _to + 1;
    [_cubeViewArray removeObjectAtIndex:_from];
    [_cubeViewArray insertObject:_selectedCube atIndex:_to];
     NSLog(@"tag is %ldi and the touch positon is x = %f,y = %f",(long)cube.tag,point.x,point.y);
    [self excuteAnimationFrom:_selectedCube with:0.5];
    
    
    NSLog(@"from value is %i",_from);
    NSLog(@"from value is %i",_to);
//    if ( _from == _to) {
//        [self excuteAnimationFrom:cube with:0.5];
//    }
//    else
//    {
//         [self setNewTagByCubeMovingFrom:_from to:_to];
//    }

}


#pragma mark - Accesories


-(CGPoint)getPositionFromTag:(NSInteger)tag {
    
    NSInteger i = tag / 3;
    NSInteger j = tag % 3;
    
    CGFloat cubewidth = self.frame.size.width / 6;
    return CGPointMake(cubewidth * (j * 2 + 1), cubewidth * (i * 2 + 1));
}


-(NSInteger)cheakMovePointArea:(CGPoint)point{
    
    NSInteger i = point.x / self.frame.size.width * 3;
    NSInteger j = point.y / self.frame.size.width * 3;
    
    NSLog(@"the area of cube  = %li",j * 3 + i);
    return i + j * 3;
}



-(void)setNewTagByCubeMovingFrom:(NSInteger)from to:(NSInteger)to  {
    
    if (to > from) {
       
        for (long i = from + 1; i < to + 1; i++) {
            CubeView *tempt = _cubeViewArray[i];
            tempt.tag = i ;
        }
        
        for (long i = from; i < to ; i++) {
            CubeView *tempt = [self viewWithTag:(i + 1)];
            [self excuteAnimationFrom:tempt with:1.0];
        }
    }
    else if(to < from){
     
        for (long i = to; i < from ; i++) {
            CubeView *tempt = _cubeViewArray[i];
            tempt.tag = i + 2;
        }
        
        for (long i = to + 1; i < from + 1 ; i++) {
            CubeView *tempt = [self viewWithTag:(i + 1)];
            [self excuteAnimationFrom:tempt with:1.0];
        }
    }
}


-(void)excuteAnimationFrom:(CubeView *)cube with:(CGFloat)duration{
    CGPoint centerPoint = [self getPositionFromTag:(cube.tag - 1)];
    [UIView animateWithDuration:duration animations:^{
        cube.center = centerPoint;
    }];
}



-(void)saveChangeToPlist {
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"CubeMenu" ofType:@"plist"];
    NSMutableArray *plistarray = [[NSMutableArray alloc] initWithContentsOfFile:filepath];
    NSLog(@"filepathstrinf is %@",filepath) ;
    NSMutableArray *titlearray = [NSMutableArray array];
    NSMutableArray *iconarray = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        NSString *title = [(CubeView *)_cubeViewArray[i] labelName];
        NSString *iconname = [(CubeView *)_cubeViewArray[i] iconName];
        [titlearray addObject:title];
        [iconarray addObject:iconname];
    }
    
    [plistarray replaceObjectAtIndex:0 withObject:titlearray];
    [plistarray replaceObjectAtIndex:1 withObject:iconarray];
    
    [plistarray writeToFile:filepath atomically:YES];
    
    
}




- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
