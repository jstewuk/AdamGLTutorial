//
//  GLK2DrawCall.h
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/6/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "GLK2ShaderProgram.h"

@interface GLK2DrawCall : NSObject

@property(nonatomic, assign) BOOL shouldClearColorBit;

@property(nonatomic, strong) GLK2ShaderProgram *shaderProgram;

- (instancetype)init;
- (float *)clearColorArray;
- (void)setClearColorRed:(float)r green:(float)g blue:(float)b alpha:(float)a;

@end
