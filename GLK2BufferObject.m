//
//  GLK2BufferObject.m
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/14/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "GLK2BufferObject.h"

@interface GLK2BufferObject ()
@property(nonatomic, readwrite, assign) GLuint glName;
@end

@implementation GLK2BufferObject

+(GLK2BufferObject *)vertexBufferObject {
    GLK2BufferObject *newObject = [[GLK2BufferObject alloc] init];
    newObject.glBufferType = GL_ARRAY_BUFFER;
    
    return newObject;
}

- (instancetype)init {
    if (self = [super init]) {
        glGenBuffers(1, &_glName);
    }
    return self;
}

- (void)dealloc {
    if (_glName > 0) {
        NSLog(@"[%@] glDeleteBuffer(%i)", [self class], _glName);
        glDeleteBuffers(1, &_glName);
    }
}

- (void)bind {
    glBindBuffer(GL_ARRAY_BUFFER, self.glName);
}

- (GLenum)getUsageEnumValueFromFrequency:(GLK2BufferObjectFrequency)frequency nature:(GLK2BufferObjectNature)nature {
    GLenum usage;
    
    switch (frequency) {
        case GLK2BufferObjectFrequencyDynmamic:
        {
            switch (nature) {
                case GLK2BufferObjectCopy:
                case GLK2BufferObjectNatureRead:
                    NSAssert(NO, @"Illegal in GL ES 2");
                    usage = 0;
                    break;
                case GLK2BufferObjectNatureDraw:
                    usage = GL_DYNAMIC_DRAW;
                    break;
                default:
                    NSAssert(NO, @"Illegal parameters");
            }
        }
            break;
        case GLK2BufferObjectFrequencyStatic:
        {
            switch (nature) {
                case GLK2BufferObjectCopy:
                case GLK2BufferObjectNatureRead:
                    NSAssert(NO, @"Illegal in GL ES 2");
                    usage = 0;
                    break;
                case GLK2BufferObjectNatureDraw:
                    usage = GL_STREAM_DRAW;
                    break;
                default:
                    NSAssert(NO, @"Illegal parameters");
            }
        }
            break;
            
        default:
            usage = -1;
            NSAssert(NO, @"Illegal parameters");
    }
    return usage;
}

- (GLuint)sizePerItemInFloats {
    return (self.bytesPerItem / 4);
}

- (void)upload:(void *)dataArray numItems:(int)count usageHint:(GLenum)usage {
    NSAssert(self.bytesPerItem > 0, @"Can't call this method until you've configured a data-format for the buffer by setting self.bytesPerItem");
    NSAssert(self.glBufferType > 0, @"Can't call this method untuil you've configured a GL type ('purpose') for the buffer by setting self.glBufferType");
    glBindBuffer(self.glBufferType, self.glName);
    glBufferData(GL_ARRAY_BUFFER, count * self.bytesPerItem, dataArray, usage);
}

@end
