//
//  YPDemoSwitchCell.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 26/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPDemoSwitchCell.h"

@implementation YPDemoSwitchCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        _switcher = [UISwitch new];
        self.accessoryView = _switcher;
    }
    
    return self;
}

- (void) prepareForReuse {
    [super prepareForReuse];
    
    _switcher.on = NO;
    [_switcher removeTarget:nil
                     action:nil
           forControlEvents:UIControlEventValueChanged];
}

@end
