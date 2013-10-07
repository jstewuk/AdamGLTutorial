//
//  GLK2DrawCall.m
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/6/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "GLK2DrawCall.h"

@implementation GLK2DrawCall {
    float clearColor[4];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setClearColorRed:1.0f green:0.0f blue:1.0f alpha:1.0f];
    }
    return self;
}

- (float *)clearColorArray {
    return &clearColor[0];
}

- (void)setClearColorRed:(float)r green:(float)g blue:(float)b alpha:(float)a {
    clearColor[0] = r;
    clearColor[1] = g;
    clearColor[2] = b;
    clearColor[3] = a;
}
@end
