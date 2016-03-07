//
//  CityPickerViewController.h
//  MagicWindowShow
//  城市
//  Created by 刘家飞 on 16/2/25.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityPickerDelegate <NSObject>

- (void)updateCity:(NSString *)city;

@end

@interface CityPickerViewController : UIViewController

@property (nonatomic, weak) id<CityPickerDelegate> delegate;

@end
