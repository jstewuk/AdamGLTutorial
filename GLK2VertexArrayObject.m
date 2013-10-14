//
//  GLK2VertexArrayObject.m
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/14/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "GLK2VertexArrayObject.h"

@implementation GLK2VertexArrayObject

- (instancetype)init {
    if (self = [super init]) {
        glGenVertexArraysOES(1, &_glName);
        _VBOs = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    if (_glName > 0) {
        NSLog(@"[%@] glDeleteVertexArraysOES(%i)", [self class], _glName);
        glDeleteVertexArraysOES(1, &_glName);
    }
}

- (GLK2BufferObject *)addVBOForAttribute:(GLK2Attribute *)targetAttribute
                          filledWithData:(void *)data
                    bytesPerArrayElement:(GLsizeiptr)bytesPerDataItem
                             arrayLength:(NSInteger)numDataItems
{
    return [self addVBOForAttribute:targetAttribute
                     filledWithData:data
               bytesPerArrayElement:bytesPerDataItem
                        arrayLength:numDataItems
                    updateFrequency:GLK2BufferObjectFrequencyStatic];
}

- (GLK2BufferObject *)addVBOForAttribute:(GLK2Attribute *)targetAttribute
                          filledWithData:(void *)data
                    bytesPerArrayElement:(GLsizeiptr)bytesPerDataItem
                             arrayLength:(NSInteger)numDataItems
                         updateFrequency:(GLK2BufferObjectFrequency)freq
{
    // Create a VBO on the GPU, store store data
    GLK2BufferObject *newVBO = [GLK2BufferObject vertexBufferObject];
    newVBO.bytesPerItem = bytesPerDataItem;
    [self.VBOs addObject:newVBO];
    
    [newVBO upload:data numItems:numDataItems
         usageHint:[newVBO getUsageEnumValueFromFrequency:freq
                                                   nature:GLK2BufferObjectNatureDraw]];
    
    glBindVertexArrayOES(self.glName);
    
    glEnableVertexAttribArray(targetAttribute.glLocation);
    GLsizei stride = 0;
    glVertexAttribPointer(targetAttribute.glLocation, newVBO.sizePerItemInFloats, GL_FLOAT, GL_FALSE, stride, 0);
    
    glBindVertexArrayOES(0);
    
    return newVBO;
}

@end
