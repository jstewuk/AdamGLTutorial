//
//  GLK2ShaderProgram.m
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/6/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "GLK2ShaderProgram.h"
#import "GLK2Shader.h"

@interface GLK2ShaderProgram ()
@property(nonatomic,strong) NSMutableDictionary *vertexAttributesByName;
@end

@implementation GLK2ShaderProgram

+ (instancetype)shaderProgramFromVertexFilename:(NSString *)vFilename fragmentFilename:(NSString *)fFilename {
    GLK2ShaderProgram *newProgram = [[GLK2ShaderProgram alloc] init];
    
    GLK2Shader *vertexShader = [GLK2Shader shaderFromFilename:vFilename type:GLK2ShaderTypeVertex];
    GLK2Shader *fragmentShader = [GLK2Shader shaderFromFilename:fFilename type:GLK2ShaderTypeFragment];
    
    [vertexShader compile];
    [fragmentShader compile];
    newProgram.vertexShader = vertexShader;
    newProgram.fragmentShader = fragmentShader;
    
    [newProgram link];
    
    return newProgram;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _glName = glCreateProgram();
        _vertexAttributesByName = [NSMutableDictionary dictionary];
        NSLog(@"[%@] Created new GL program with GL name = %i", [self class], self.glName);
    }
    return self;
}

- (void)dealloc {
    if (_glName) {
        glDeleteProgram(_glName);
        NSLog(@"[%@] dealloc: Deleted GL program with GL name = %i", [self class], self.glName);
    } else {
        NSLog(@"[%@] dealloc: NOT deleting GL program (no GL name)", [self class]);
    }
}

- (void)setFragmentShader:(GLK2Shader *)fragmentShader {
    if (_fragmentShader == fragmentShader) return;
    
    if (_fragmentShader) glDetachShader(self.glName, _fragmentShader.glName);
    
    _fragmentShader = fragmentShader;
    
    if (_fragmentShader) glAttachShader(self.glName, fragmentShader.glName);
}

- (void)setVertexShader:(GLK2Shader *)vertexShader {
    if (_vertexShader == vertexShader) return;
    
    if (_vertexShader) glDetachShader(self.glName, _vertexShader.glName);
    
    _vertexShader = vertexShader;
    
    if (_vertexShader) glAttachShader(self.glName, vertexShader.glName);
}


- (void)link {
    [GLK2ShaderProgram linkProgram:self.glName];
    self.status = GLK2ShaderProgramStatusLinked;
    
    self.vertexShader.status = GLK2ShaderStatusLinked;
    self.fragmentShader.status = GLK2ShaderStatusLinked;
    
    if (self.vertexShader) {
        glDetachShader(self.glName, self.vertexShader.glName);
        glDeleteShader(self.vertexShader.glName);
    }
    
    if (self.fragmentShader) {
        glDetachShader(self.glName, self.fragmentShader.glName);
        glDeleteShader(self.fragmentShader.glName);
    }
    
    GLint numCharactersInLongestName;
    glGetProgramiv(self.glName, GL_ACTIVE_ATTRIBUTE_MAX_LENGTH, &numCharactersInLongestName);
    char* nextAttributeName = malloc( sizeof(char)  * numCharactersInLongestName);
    
    GLint numAttributesFound;
    glGetProgramiv(self.glName, GL_ACTIVE_ATTRIBUTES, &numAttributesFound);
    NSLog(@"[%@] ----- WARNING: this is not recommended; I am implementing to check if it works but "
          @"you should very rarely use glGetActiveAttrib - instead you should be using an explicit "
          @"glBindAttribLocation BEFORE linking", [self class]);
    for (int i = 0; i< numAttributesFound; i++ ) {
        GLint attributeLocation, attributeSize;
        GLenum attributeType;
        NSString* stringName;
        
        glGetActiveAttrib(self.glName, i, numCharactersInLongestName, NULL, &attributeSize, &attributeType, nextAttributeName);
        attributeLocation = glGetAttribLocation(self.glName, nextAttributeName);
        stringName = [NSString stringWithUTF8String:nextAttributeName];
        
        GLK2Attribute* newAttribute = [GLK2Attribute attributeNamed:stringName GLType:attributeType GLLocation:attributeLocation];
        
        self.vertexAttributesByName[stringName] = newAttribute;
    }
    
    free(nextAttributeName);
}


- (GLK2Attribute *)attributeNamed:(NSString *)name {
    return [self.vertexAttributesByName objectForKey:name];
}

- (NSArray *)allAttributes {
    return [self.vertexAttributesByName allValues];
}

+ (void)linkProgram:(GLuint)programRef {
    GLint status;
    glLinkProgram(programRef);
    glGetProgramiv(programRef, GL_LINK_STATUS, &status);
}

@end
