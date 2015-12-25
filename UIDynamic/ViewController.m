//
//  ViewController.m
//  empty
//
//  Created by admin on 15/7/31.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


#pragma mark 创建一个UIDynamicAnimator
-(UIDynamicAnimator *)animator
{
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.blueView setTransform:CGAffineTransformMakeRotation(M_PI_4)];
    _animator = [self animator];
    
}
#pragma mark 点击开始下落
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //test Gravity
    //[self testGravity];

    //testGravityCollision
   // [self testGravityCollision];
    
    //testGravityCollision2
    //[self testGravityCollision2];
    
    //[self testGravityCollision3];
    //[self testGravityCollision4];
    
    #pragma mark 捕捉行为
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    //1.创建捕捉行为
    //需要传入两个参数：一个物理仿真元素，一个捕捉点

    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self.blueView snapToPoint:point];
    
    //设置防震系数（0~1，数值越大，震动的幅度越小）
    snapBehavior.damping = 0.1;
    
    //用这个仿真必须remove其他的behavior
    [_animator removeAllBehaviors];
    [_animator addBehavior:snapBehavior];
    
    
}

#pragma mark test Gravity
-(void)testGravity
{
    //创建一个UIGravityBehavior 并且将UIView添加到里面
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]init];
    
    //为UIDynamicAnimator 添加一个行为
    [gravity addItem:_blueView];
    //执行仿真
    [_animator addBehavior:gravity];

}
#pragma mark TestGravityCollision
-(void)testGravityCollision
{
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]init];
    
    
    //将所有视图添加一个重力行为
    [gravity addItem:_blueView];
    //[gravity addItem:_segement];
    [gravity addItem:_progress];
    //创建一个重力碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]init];
    [collision addItem:_segement];
    [collision addItem:_blueView];
    [collision addItem:_progress];
    
    //让参照视图的边框作为碰撞的边界
    
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //执行仿真
    [_animator addBehavior:gravity];
    [_animator addBehavior:collision];
    
}
-(void)testGravityCollision2
{
    //创建一个重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]init];
   // 配置gravity
    gravity.magnitude = 100;
    gravity.gravityDirection = CGVectorMake(0, 1);
    
    //为view添加一个重力行为
    [gravity addItem:_blueView];
    
    //创建碰撞
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[_blueView,_progress,_segement]];
    
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //执行仿真
    [_animator addBehavior:gravity];
    [_animator addBehavior:collision];
    

}


#pragma mark 用两根线做为碰撞的边界
-(void)testGravityCollision3
{
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[_blueView]];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[_blueView,_progress,_segement]];
    
    CGPoint startP = CGPointMake(0, 600);
    CGPoint endP = CGPointMake(500, 600);
    [collision addBoundaryWithIdentifier:@"line1" fromPoint:startP toPoint:endP];
    
    //执行仿真
    [_animator addBehavior:gravity];
    [_animator addBehavior:collision];
    
}

#pragma mark 用圆作为碰撞的边界
-(void)testGravityCollision4
{

    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]init];
    [gravity addItem:_blueView];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[_blueView,_segement,_progress]];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100 , 0, 100, 100)];
    
    //显示path
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.fillColor = [[UIColor grayColor]CGColor];
    shapeLayer.path = path.CGPath ;
    shapeLayer.bounds = CGRectMake(0, 0, 100, 100);
    shapeLayer.position = CGPointMake(100, 500) ;
    [self.view.layer addSublayer:shapeLayer];
    
    [collision addBoundaryWithIdentifier:@"line2" forPath:path];
    
    [_animator addBehavior:gravity];
    [_animator addBehavior:collision];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
