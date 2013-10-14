//
//  GLK2BufferObject.h
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/14/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GLK2BufferObjectFrequency) {
    GLK2BufferObjectFrequencyStream,
    GLK2BufferObjectFrequencyStatic,
    GLK2BufferObjectFrequencyDynmamic
};

typedef NS_ENUM(NSInteger,GLK2BufferObjectNature) {
    GLK2BufferObjectNatureDraw,
    GLK2BufferObjectNatureRead,
    GLK2BufferObjectCopy
};

@interface GLK2BufferObject : NSObject

@property(nonatomic, readonly, assign) GLuint glName;
@property(nonatomic, assign) GLenum glBufferType;
@property(nonatomic, assign) GLsizeiptr bytesPerItem;
@property(nonatomic, readonly, assign) GLuint sizePerItemInFloats;

+ (GLK2BufferObject *)vertexBufferObject;

- (GLenum)getUsageEnumValueFromFrequency:(GLK2BufferObjectFrequency)frequency nature:(GLK2BufferObjectNature)nature;

- (void)upload:(void *)dataArray numItems:(int)count usageHint:(GLenum)usage;

@end
