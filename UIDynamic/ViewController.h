//
//  ViewController.h
//  UIDynamic
//
//  Created by admin on 15/8/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segement;
@property (nonatomic,strong) UIDynamicAnimator *animator;
@end

