//
//  GLK2VertexArrayObject.h
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/14/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLK2BufferObject.h"
#import "GLK2Attribute.h"

@interface GLK2VertexArrayObject : NSObject

@property(nonatomic, readonly, assign) GLuint glName;
@property(nonatomic, strong) NSMutableArray *VBOs;

- (GLK2BufferObject *)addVBOForAttribute:(GLK2Attribute *)targetAttribute
                          filledWithData:(void *)data
                    bytesPerArrayElement:(GLsizeiptr)bytesPerDataItem
                             arrayLength:(NSInteger)numDataItems;

- (GLK2BufferObject *)addVBOForAttribute:(GLK2Attribute *)targetAttribute
                          filledWithData:(void *)data
                    bytesPerArrayElement:(GLsizeiptr)bytesPerDataItem
                             arrayLength:(NSInteger)numDataItems
                         updateFrequency:(GLK2BufferObjectFrequency)freq;


@end
