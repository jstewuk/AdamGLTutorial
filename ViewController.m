//
//  ViewController.m
//  AdamGLTutorial2
//
//  Created by James Stewart on 10/6/13.
//  Copyright (c) 2013 Stewartstuff. All rights reserved.
//

#import "ViewController.h"
#import "GLK2DrawCall.h"
#import "GLK2Shader.h"
#import "GLK2ShaderProgram.h"

@interface ViewController () <GLKViewControllerDelegate>
@property(nonatomic, strong) NSMutableArray *drawCalls;

@end

@implementation ViewController

- (void)dealloc {
    if ([EAGLContext currentContext] == self.localContext) {
        [EAGLContext setCurrentContext:nil];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.localContext == nil) {
        self.localContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    NSAssert( self.localContext != nil, @"Failed to create ES context");
    [EAGLContext setCurrentContext:self.localContext];
    
    self.drawCalls = [NSMutableArray array];
    self.delegate = self;
    GLK2DrawCall *simpleClearingCall = [[GLK2DrawCall alloc] init];
    simpleClearingCall.shouldClearColorBit = YES;
    [self.drawCalls addObject:simpleClearingCall];
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.localContext;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    GLK2DrawCall *drawOneTriangle = [[GLK2DrawCall alloc] init];
    drawOneTriangle.shaderProgram = [GLK2ShaderProgram shaderProgramFromVertexFilename:@"VertexPositionUnprojected"
                                                                      fragmentFilename:@"FragmentColorOnly"];
    glUseProgram(drawOneTriangle.shaderProgram.glName);
    GLK2Attribute *attribute = [drawOneTriangle.shaderProgram attributeNamed:@"position"];
    //[drawOneTriangle setClearColorRed:0 green:1.0 blue:0 alpha:1.0f];
    //drawOneTriangle.shouldClearColorBit = NO;
    
    GLfloat z = -0.5;
    GLKVector3* cpuBuffer = malloc(sizeof(GLKVector3) * 3);
    cpuBuffer[0] = GLKVector3Make(-1, -1, z);
    cpuBuffer[1] = GLKVector3Make( 0,  1, z);
    cpuBuffer[2] = GLKVector3Make( 1, -1, z);

    GLuint VBOName, VAOName;
    glGenVertexArraysOES(1, &VAOName);
    glBindVertexArrayOES(VAOName);
    
    glGenBuffers(1, &VBOName);
    glBindBuffer(GL_ARRAY_BUFFER, VBOName);
    glBufferData(GL_ARRAY_BUFFER, 3 * sizeof(GLKVector3), cpuBuffer, GL_DYNAMIC_DRAW);
    
    glEnableVertexAttribArray(attribute.glLocation);
    glVertexAttribPointer(attribute.glLocation, 3, GL_FLOAT, GL_FALSE, 0, 0);
    
    [self.drawCalls addObject:drawOneTriangle];
}


#pragma mark - GLKViewControllerDelegate
- (void)glkViewControllerUpdate:(GLKViewController *)controller {
    if (controller != self) return;
    
    [self renderSingleFrame];
}

- (void)renderSingleFrame {
    if ([EAGLContext currentContext] == nil) {
        NSLog(@"We have no gl context, skipping all frames rendering");
        return;
    }
    
    if (self.drawCalls == nil || [self.drawCalls count] < 1) {
        NSLog(@"No drawcalls specified");
    }
    
    for (GLK2DrawCall *drawCall in self.drawCalls) {
        [self renderSingleDrawCall:drawCall];
    }
}

- (void)renderSingleDrawCall:(GLK2DrawCall *)drawCall {
    float *newClearColor = [drawCall clearColorArray];
    glClearColor(newClearColor[0], newClearColor[1], newClearColor[2], newClearColor[3]);
    glClear( (drawCall.shouldClearColorBit ? GL_COLOR_BUFFER_BIT : 0));
    
    if (drawCall.shaderProgram != nil) {
        glUseProgram(drawCall.shaderProgram.glName);
    } else {
        glUseProgram(0);
    }
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

@end
