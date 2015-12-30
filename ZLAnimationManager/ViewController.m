//
//  ViewController.m
//  ZLAnimationManager
//
//  Created by Mac on 15/12/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "ViewController.h"
#import "AnimationManager.h"
@interface ViewController ()
{
    UITableView *animationTableView;
    float SWidth;
    float SHeight;
    NSMutableArray * animationNameArray;
    UIView * animationView;
    CAShapeLayer * sLayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SWidth = [[UIScreen mainScreen] bounds].size.width;
    SHeight = [[UIScreen mainScreen] bounds].size.height;
    animationNameArray = [NSMutableArray array];
    
    [self initAnimationData];
    animationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SWidth, SHeight-20)];
    [animationTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [animationTableView setDataSource:self];
    [animationTableView setDelegate:self];
    [self.view addSubview:animationTableView];
    
    animationView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [animationView setBackgroundColor:[UIColor redColor]];
    [animationView setHidden:YES];
    [self.view addSubview:animationView];
    
    sLayer = [CAShapeLayer layer];
    CGPathRef path = CGPathCreateWithRoundedRect(animationView.frame, 1, 1, nil);
    sLayer.path = path;
    [sLayer setFillColor:[UIColor clearColor].CGColor];
    [sLayer setStrokeColor:[UIColor blackColor].CGColor];
    [sLayer setLineWidth:2];
    [animationView.layer addSublayer:sLayer];
    CGPathRelease(path);
}

-(void)initAnimationData{
    [animationNameArray addObject:@"Move Animation"];
    [animationNameArray addObject:@"Move Animation Delay"];
    [animationNameArray addObject:@"Rotate Animation"];
    [animationNameArray addObject:@"Rotate Animation Delay"];
    [animationNameArray addObject:@"Rotate Degree Animation"];
    [animationNameArray addObject:@"Rotate Degree Delay Animation"];
    [animationNameArray addObject:@"Optical To Animation"];
    [animationNameArray addObject:@"Optical From To Animation"];
    [animationNameArray addObject:@"Optical Show Animation"];
    [animationNameArray addObject:@"Optical Show Delay Animation"];
    [animationNameArray addObject:@"Optical Hide Animation"];
    [animationNameArray addObject:@"Optical Hide Delay Animation"];
    [animationNameArray addObject:@"Color Change Animation"];
    [animationNameArray addObject:@"Color Change Delay Animation"];
    [animationNameArray addObject:@"Stoker Color Change Animation"];
    [animationNameArray addObject:@"Stoker Color Change Delay Animation"];
    [animationNameArray addObject:@"Stoker Move Animation"];
    [animationNameArray addObject:@"Stoker Move Delay Animation"];
    [animationNameArray addObject:@"Scale Animation"];
    [animationNameArray addObject:@"Shake Animation"];
}

#pragma mark -- UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld",indexPath.row]];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld",indexPath.row]];
    }
    NSString * animationName = [animationNameArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:animationName];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [animationNameArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (animationView.hidden == NO) {
        
        return;
    }
    switch (indexPath.row) {
        case 0:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] move:animationView from:CGPointMake(0, 0) to:CGPointMake(SWidth, SHeight) duration:3 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 1:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] move:animationView from:CGPointMake(0, 0) to:CGPointMake(SWidth, SHeight) duration:3 delay:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 2:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] rotate:animationView duration:3 repeatCount:5 timingFunction:nil clockwise:YES complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 3:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] rotate:animationView duration:3 delay:1 repeatCount:5 timingFunction:nil clockwise:YES complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 4:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] rotate:animationView toDegree:180 duration:2 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 5:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] rotate:animationView toDegree:200 duration:2 delay:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 6:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] opacity:animationView toValue:.6 duration:1 delay:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 7:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] opacity:animationView fromValue:.6 toValue:.2 duration:1 delay:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 8:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] opacityShow:animationView duration:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 9:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] opacityShow:animationView duration:1 delay:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 10:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] opacityHide:animationView duration:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 11:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] opacityHide:animationView duration:1 delay:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 12:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] colorChange:animationView fromColor:[UIColor redColor] toColor:[UIColor blueColor] duration:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 13:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] colorChange:animationView fromColor:[UIColor redColor] toColor:[UIColor blueColor] duration:1 delay:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 14:
        {
            if ([sLayer isKindOfClass:[CAShapeLayer class]]) {
                animationView.center = CGPointMake(20, 20);
                animationView.hidden = NO;
                [[AnimationManager sharedAnimationManager] strokeColor:sLayer fromColor:[UIColor greenColor] toColor:[UIColor blackColor] duration:2 complete:^{
                    animationView.hidden = YES;
                }];
            }
        }
            break;
        case 15:
        {
            if ([sLayer isKindOfClass:[CAShapeLayer class]]) {
                animationView.center = CGPointMake(20, 20);
                animationView.hidden = NO;
                [[AnimationManager sharedAnimationManager] strokeColor:sLayer fromColor:[UIColor blueColor] toColor:[UIColor redColor] duration:2 delay:1 complete:^{
                    animationView.hidden = YES;
                }];
            }
        }
            break;
        case 16:
        {
            if ([sLayer isKindOfClass:[CAShapeLayer class]]) {
                animationView.center = CGPointMake(20, 20);
                animationView.hidden = NO;
                [[AnimationManager sharedAnimationManager] strokeMove:sLayer from:0 to:1 duration:2 complete:^{
                    animationView.hidden = YES;
                }];
            }
        }
            break;
        case 17:
        {
            if ([sLayer isKindOfClass:[CAShapeLayer class]]) {
                animationView.center = CGPointMake(20, 20);
                animationView.hidden = NO;
                [[AnimationManager sharedAnimationManager] strokeMove:sLayer from:0 to:1 duration:2 delay:1 complete:^{
                    animationView.hidden = YES;
                }];
            }
        }
            break;
        case 18:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] scale:animationView from:0 to:1 duration:2 delay:1 complete:^{
                animationView.hidden = YES;
            }];
        }
            break;
        case 19:
        {
            animationView.center = CGPointMake(20, 20);
            animationView.hidden = NO;
            [[AnimationManager sharedAnimationManager] mailIconAnimation:animationView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[AnimationManager sharedAnimationManager] stopAnimation:animationView];
                animationView.hidden = YES;
            });
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
