//
//  JYIconImageView.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/28.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYIconImageView.h"
#import "UIImageView+WebCache.h"
@interface JYIconImageView()
@property(nonatomic,strong)UIImageView *verifiedImage;

@end
@implementation JYIconImageView
- (UIImageView *)verifiedImage
{
    if (!_verifiedImage) {
        self.verifiedImage = [[UIImageView alloc] init];
        [self addSubview:self.verifiedImage];
    }
    return _verifiedImage;
}
-(void)setUser:(JYUser *)user{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];

    switch (user.verified_type) {
        case JYUserVerifiedTypePersonal:
            self.verifiedImage.image = [UIImage imageNamed:@"avatar_vip"];
            self.verifiedImage.hidden = NO;
            break;
        case JYUserVerifiedTypeOrgEnterprice:
        case JYUserVerifiedTypeOrgMedia:
        case JYUserVerifiedTypeOrgWebsite:
            self.verifiedImage.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            self.verifiedImage.hidden = NO;
            break;
        case JYUserVerifiedTypeDaren:
            self.verifiedImage.image = [UIImage imageNamed:@"avatar_grassroot"];
            self.verifiedImage.hidden = NO;
            break;
        default:
            self.verifiedImage.hidden = YES;
            break;
    }
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.verifiedImage.size = self.verifiedImage.image.size;
    self.verifiedImage.x = self.width - self.verifiedImage.width *0.8;
    self.verifiedImage.y = self.height - self.verifiedImage.height *0.8;
}
@end
