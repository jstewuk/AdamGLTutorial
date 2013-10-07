//
//  GLK2Shader.m
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/6/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "GLK2Shader.h"

@implementation GLK2Shader

+ (instancetype)shaderFromFilename:(NSString *)filename type:(GLK2ShaderType)type {
    GLK2Shader *newShader = [[GLK2Shader alloc] init];
    newShader.type = type;
    newShader.fileName = filename;
    return newShader;
}


- (void)compile {
    NSAssert( self.status == GLK2ShaderStatusUncompiled, @"Can't compile, already compiled");
    
    NSString *shaderPathName;
    GLenum glShaderType;
    NSString* stringShaderType;
    
    switch (self.type) {
        case GLK2ShaderTypeFragment: {
            glShaderType = GL_FRAGMENT_SHADER;
            shaderPathName = [[NSBundle mainBundle] pathForResource:self.fileName ofType:@"fsh"];
            stringShaderType = @"fragment";
            break;
        }
        case GLK2ShaderTypeVertex: {
            glShaderType = GL_VERTEX_SHADER;
            shaderPathName = [[NSBundle mainBundle] pathForResource:self.fileName ofType:@"vsh"];
            stringShaderType = @"vertex";
            break;
        }
    }
    
    [GLK2Shader compileShader:&_glName type:glShaderType file:shaderPathName];
    self.status = GLK2ShaderStatusCompiled;
}

+ (void)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file {
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    NSAssert( source, @"Failed to load shader from file: %@", file);
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
    }
}

@end
