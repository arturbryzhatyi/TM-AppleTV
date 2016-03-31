//
//  SearchTextField.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/31/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchTextFieldDeleagte <NSObject>

- (void)textFieldDictation:(id)result;

@end

@interface SearchTextField : UITextField

@end
