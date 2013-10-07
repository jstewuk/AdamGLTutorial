//
//  GLK2Attribute.m
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/6/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "GLK2Attribute.h"

@implementation GLK2Attribute

+ (GLK2Attribute *)attributeNamed:(NSString *)nameOfAttribute GLType:(GLenum)openGLType GLLocation:(GLint)openGLLocation {
    GLK2Attribute* newValue = [[GLK2Attribute alloc] init];
    newValue.nameInSourceFile = nameOfAttribute;
    newValue.glType = openGLType;
    newValue.glLocation = openGLLocation;
    
    return newValue;
}


@end
