//
//  ColorCell.m
//  CollectionViewTest
//
//  Created by wenjie hua on 2017/2/23.
//  Copyright © 2017年 jingcheng. All rights reserved.
//

#import "ColorCell.h"
@interface ColorCell()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation ColorCell
- (void)setTitle:(NSString *)title{
    self.lblTitle.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
