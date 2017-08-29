//
//  ATBViewController.m
//  ATBasicSounds
//
//  Created by Audrey M Tam on 20/03/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "ATBViewController.h"
#import "AudioController.h"

@interface ATBViewController ()

@property (strong, nonatomic) AudioController *audioController;

@end

@implementation ATBViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.audioController = [[AudioController alloc] init];
    [self.audioController tryPlayMusic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)spaceshipTapped:(id)sender {
    //The call below uses AudioServicesPlaySystemSound to play
    //the short pew-pew sound.
	[self.audioController playSystemSound];
	[self fireBullet];
}

- (void)fireBullet {
    // In IB, the button to top layout guide constraint is set to 229, so
    // the bullets appear in the correct place, on both 3.5" and 4" screens
	UIImageView *bullets = [[UIImageView alloc] initWithFrame:CGRectMake(84, 256, 147, 29)];
	bullets.image = [UIImage imageNamed:@"bullets.png"];
	[self.view addSubview:bullets];
	[self.view sendSubviewToBack:bullets];
	[UIView beginAnimations:@"shoot" context:(__bridge void *)(bullets)];
	CGRect frame = bullets.frame;
	frame.origin.y = -29;
	bullets.frame = frame;
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[UIView commitAnimations];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	UIImageView *bullets = (__bridge UIImageView *)context;
	[bullets removeFromSuperview];
}

@end
