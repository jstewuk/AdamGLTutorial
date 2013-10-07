//
//  GLK2ShaderProgram.h
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/6/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLK2Attribute.h"

typedef NS_ENUM(NSInteger, GLK2ShaderProgramStatus) {
    GLK2ShaderProgramStatusUnlinked,
    GLK2ShaderProgramStatusLinked
};

@class GLK2Shader;


@interface GLK2ShaderProgram : NSObject

+ (instancetype)shaderProgramFromVertexFilename:(NSString *)vFilename fragmentFilename:(NSString *)fFilename;

@property(nonatomic, assign) GLK2ShaderProgramStatus status;
@property(nonatomic, assign) GLuint glName;
@property(nonatomic, strong) GLK2Shader *vertexShader;
@property(nonatomic, strong) GLK2Shader *fragmentShader;

-(GLK2Attribute *)attributeNamed:(NSString*)name;

-(NSArray *)allAttributes;

-(instancetype)init;


@end
