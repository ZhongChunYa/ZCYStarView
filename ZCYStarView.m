//
//  ZCYStarView.m
//  ZCY_StarView
//
//  Created by 钟淳亚 on 2016/10/25.
//  Copyright © 2016年 钟淳亚. All rights reserved.
//

#import "ZCYStarView.h"

#define BaseTag 1000

@interface ZCYStarView ()

@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) CGSize starSize;
@property (nonatomic, assign) NSInteger starNum;
@property (nonatomic, assign) NSInteger starSpace;
@property (nonatomic, copy) NSString *deselectedImage;
@property (nonatomic, copy) NSString *selectedImage;
@property (nonatomic, weak) id<StarViewDelegate> delegate;

@end

@implementation ZCYStarView

+ (instancetype)initWithStarSize:(CGSize)starSize starNum:(NSInteger)starNum starSpace:(NSInteger)starSpace deselectedName:(NSString *)deselectedName selectedName:(NSString *)selectedName isIndicator:(BOOL)isIndicator delegate:(id<StarViewDelegate>)delegate {
    
    ZCYStarView *starView = [[self alloc] initWithFrame:CGRectMake(0, 0, starSize.width*starNum+starSpace*(starNum-1), starSize.height)];
    starView.starSize = starSize;
    starView.starNum = starNum;
    starView.starSpace = starSpace;
    starView.deselectedImage = deselectedName;
    starView.selectedImage = selectedName;
    starView.delegate = delegate;
    
    for (int i = 0; i < starNum; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((starSize.width+starSpace)*i, 0, starSize.width, starSize.height)];
        imageView.tag = BaseTag+i;
        imageView.image = [UIImage imageNamed:deselectedName];
        [starView addSubview:imageView];
        if (!isIndicator) {
            starView.userInteractionEnabled = YES;
            
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:starView action:@selector(starViewTaped:)];
            [imageView addGestureRecognizer:tap];
        }
    }
    
    return starView;
}

- (void)displayScore:(NSInteger)score {
    if (score<0) {
        self.score = 0;
    } else if (score > self.starNum) {
        self.score = self.starNum;
    } else {
        self.score = score;
    }
    NSInteger tag = (int)(self.score-1+0.5)+BaseTag;
    for (int i = 1004; i > tag; i--) {
        UIImageView *imageView = [self viewWithTag:i];
        imageView.image = [UIImage imageNamed:self.deselectedImage];
    }
    for (int i = BaseTag; i <= tag; i++) {
        UIImageView *imageView = [self viewWithTag:i];
        imageView.image = [UIImage imageNamed:self.selectedImage];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor greenColor];
        self.score = 0;
    }
    return self;
}

- (void)starViewTaped:(UITapGestureRecognizer *)sender {
    NSInteger tag = sender.view.tag;
    for (int i = 1004; i > tag; i--) {
        UIImageView *imageView = [self viewWithTag:i];
        imageView.image = [UIImage imageNamed:self.deselectedImage];
    }
    for (int i = BaseTag; i <= tag; i++) {
        UIImageView *imageView = [self viewWithTag:i];
        imageView.image = [UIImage imageNamed:self.selectedImage];
    }
    [self.delegate scoreChanged:tag-BaseTag+1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    [self calcX:touchPoint.x];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    [self calcX:touchPoint.x];
}

- (void)calcX:(float)x {
    int num = 0;
    BOOL b = YES;
    while (b) {
        if (x >= self.starSize.width/2+num*(self.starSize.width+self.starSpace))
            num++;
        else
            b = NO;
    }
    [self displayScore:num];
}

@end
