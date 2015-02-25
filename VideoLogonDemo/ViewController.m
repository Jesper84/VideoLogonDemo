//
//  ViewController.m
//  VideoLogonDemo
//
//  Created by Jesper Nielsen on 25/02/15.
//  Copyright (c) 2015 App-it.dk. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@implementation ViewController{
    MPMoviePlayerController *_player;
    UIButton *_loginButton;
    UIButton *_registerButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [self initMovieController];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    _loginButton = [UIButton new];
    [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.view addSubview:_loginButton];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.backgroundColor = [UIColor colorWithRed:0.18 green:0.35 blue:1 alpha:1];
    _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    _loginButton.alpha = 0;
    _registerButton = [UIButton new];
    [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
    [self.view addSubview:_registerButton];

    _registerButton.backgroundColor = [UIColor colorWithRed:0.18 green:0.35 blue:1 alpha:1];
    _registerButton.translatesAutoresizingMaskIntoConstraints = NO;
    _registerButton.alpha = 0;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-30]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-30]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[login(register)]-30-[register]-|" options:0 metrics:nil views:@{@"login":_loginButton,@"register":_registerButton}]];
    
    
    [self.view needsUpdateConstraints];
    
    [window addSubview:_player.view];
    [_player play];
    [self performSelector:@selector(animateButtons) withObject:nil afterDelay:1.0];
}

- (void)initMovieController
{
    _player = [[MPMoviePlayerController alloc] initWithContentURL:nil];
    _player.view.frame = [[UIScreen mainScreen]bounds];
    _player.controlStyle = MPMovieControlStyleNone;
    _player.scalingMode = MPMovieScalingModeNone;
    _player.allowsAirPlay = NO;
    _player.repeatMode = MPMovieRepeatModeOne;
    NSURL *movieURL = [[NSBundle mainBundle] URLForResource:@"testVideo" withExtension:@"mov"];
    [_player setContentURL:movieURL];
    [_player setScalingMode:MPMovieScalingModeFill];
    
}

- (void)animateButtons
{
    [UIView animateWithDuration:1.5 animations:^{
        _loginButton.alpha = _registerButton.alpha = 1;
    }];
}

- (void)login
{
    [UIView animateWithDuration:2.0 animations:^{
        _registerButton.alpha = 0;
        _loginButton.center = self.view.center;
        self.view.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        _player = nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
