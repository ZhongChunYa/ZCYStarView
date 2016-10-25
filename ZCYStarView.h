//
//  ZCYStarView.h
//  ZCY_StarView
//
//  Created by 钟淳亚 on 2016/10/25.
//  Copyright © 2016年 钟淳亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarViewDelegate <NSObject>

@required
- (void)scoreChanged:(NSInteger)newScore;

@end

@interface ZCYStarView : UIView

/**
 *  初始化方法
 *
 *  @param starSize         星星大小
 *  @param starNum          星星个数
 *  @param starSpace        星星间距
 *  @param deselectedName   未选中图片
 *  @param selectedName     选中图片
 *  @param isIndicator      是否指示器
 *  @param delegate         星级变动代理
 *
 *  @return WQLStarView
*/
+ (instancetype)initWithStarSize:(CGSize)starSize starNum:(NSInteger)starNum starSpace:(NSInteger)starSpace deselectedName:(NSString *)deselectedName selectedName:(NSString *)selectedName isIndicator:(BOOL)isIndicator delegate:(id<StarViewDelegate>)delegate;

// 设置分数
- (void)displayScore:(NSInteger)score;

@end
