//
//  LLHAnimaTextField.h
//  指尖叫货
//
//  Created by rimi on 16/6/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, XMNAnimTextFieldState) {
    XMNAnimTextFieldStateNormal = 0,
    XMNAnimTextFieldStateEditing,
    XMNAnimTextFieldStateError,
};

typedef NS_ENUM(NSUInteger, XMNAnimTextFieldInputType) {
    XMNAnimTextFieldInputTypeDefault = UIKeyboardTypeDefault,
    XMNAnimTextFieldInputTypePassword,
    XMNAnimTextFieldInputTypeTips,
};
@interface LLHAnimaTextField : UIView
@property (nonatomic, copy, readonly) NSString *text;

/** textFiled状态  默认XMNAnimTextFiledStateNormal */
@property (nonatomic, assign) XMNAnimTextFieldState state;

/** textFiled输入类型 默认XMNAnimTextFieldInputTypeDefault=UIKeyboardTypeDefault */
@property (nonatomic, assign) XMNAnimTextFieldInputType inputType;

/** textFiled代理 同UITextFiledDelegate */
@property (nonatomic, weak) id<UITextFieldDelegate> delegate;

/** 缩放系数,默认placeHolderIV,placeHolderL 缩放到多少 范围 0 - 1 默认.8f */
@property (nonatomic, assign) CGFloat minimumScaleFactor;



@property (nonatomic, copy) NSString *placeHolderText;

@property (nonatomic, strong) UIImage *tipsIcon;
@property (nonatomic, strong) UIImage *placeHolderIcon;
@property (nonatomic, strong) UIImage *placeHolderHightlightIcon;

/** placeHolder 普通状态 未选中下文字,边框颜色  默认灰色 */
@property (nonatomic, strong) UIColor *placeHolderColor;

/** placeHolder 编辑状文字时 边框颜色  默认灰色 */
@property (nonatomic, strong) UIColor *placeHolderHighlightColor;

/** placeHolder 错误状态下 文字,边框颜色  默认绿色 */
@property (nonatomic, strong) UIColor *placeHolderErrorColor;

@end
