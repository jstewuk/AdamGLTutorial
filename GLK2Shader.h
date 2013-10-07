//
//  GLK2Shader.h
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/6/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GLK2ShaderType) {
    GLK2ShaderTypeVertex,
    GLK2ShaderTypeFragment
};

typedef NS_ENUM(NSInteger, GLK2ShaderStatus) {
    GLK2ShaderStatusUncompiled,
    GLK2ShaderStatusCompiled,
    GLK2ShaderStatusLinked
};

@interface GLK2Shader : NSObject
@property(nonatomic, assign) GLuint glName;
@property(nonatomic, assign) GLK2ShaderType type;
@property(nonatomic, assign) GLK2ShaderStatus status;
@property(nonatomic, strong) NSString *fileName;


+ (instancetype)shaderFromFilename:(NSString *)filename type:(GLK2ShaderType)type;

- (void)compile;
@end
