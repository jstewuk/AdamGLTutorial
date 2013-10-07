//
//  GLK2Attribute.h
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/6/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLK2Attribute : NSObject

+ (GLK2Attribute *)attributeNamed:(NSString *)nameOfAttribute GLType:(GLenum)openGLType GLLocation:(GLint)openGLLocation;

@property(nonatomic, strong) NSString *nameInSourceFile;
@property(nonatomic, assign) GLint glLocation;

@property(nonatomic, assign) GLenum glType;

@end
