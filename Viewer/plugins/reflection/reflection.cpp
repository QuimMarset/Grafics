#include "reflection.h"
#include <QCoreApplication>


void Reflection::onPluginLoad()
{
    GLWidget & g = *glwidget();
    g.makeCurrent();
    // Carregar shader, compile & link 
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile("plugins/reflection/reflection.vert");

    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile("plugins/reflection/reflection.frag");

    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();

    // Setup texture
    g.glActiveTexture(GL_TEXTURE0);
    g.glGenTextures( 1, &textureId);
    g.glBindTexture(GL_TEXTURE_2D, textureId);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR );
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    g.glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, g.width(), g.height(), 0, GL_RGB, GL_FLOAT, NULL);
    g.glBindTexture(GL_TEXTURE_2D, 0);

}


void drawRect(GLWidget &g)
{
    static bool created = false;
    static GLuint VAO_rect;

    // 1. Create VBO Buffers
    if (!created)
    {
        created = true;
        
        // Create & bind empty VAO
        g.glGenVertexArrays(1, &VAO_rect);
        g.glBindVertexArray(VAO_rect);

        Point boundingEscenaMin = g.scene()->boundingBox().min();
        Point boundingEscenaMax = g.scene()->boundingBox().max();

        // Create VBO with (x,y,z) coordinates
        float coords[] = {  boundingEscenaMin.x(), boundingEscenaMin.y(), boundingEscenaMin.z(), 
                            boundingEscenaMax.x(), boundingEscenaMin.y(), boundingEscenaMin.z(), 
                            boundingEscenaMin.x(), boundingEscenaMin.y(), boundingEscenaMax.z(), 
                            boundingEscenaMax.x(), boundingEscenaMin.y(), boundingEscenaMax.z()};

        GLuint VBO_coords;
        g.glGenBuffers(1, &VBO_coords);
        g.glBindBuffer(GL_ARRAY_BUFFER, VBO_coords);
        g.glBufferData(GL_ARRAY_BUFFER, sizeof(coords), coords, GL_STATIC_DRAW);
        g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
        g.glEnableVertexAttribArray(0);
        g.glBindVertexArray(0);
    }

    // 2. Draw
    g.glBindVertexArray (VAO_rect);
    g.glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    g.glBindVertexArray(0);
}



bool Reflection::paintGL()
{
    GLWidget & g = *glwidget();

    // Pas 1: Dibuixar escena reflectida i guardar-la en una textura
    g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
    QMatrix4x4 modelMatrix = QMatrix4x4();
    Point boundingMin = scene()->boundingBox().min();
    modelMatrix.translate(0,boundingMin.y(),0);
    modelMatrix.rotate(180.0,QVector3D(0,0,1));
    modelMatrix.translate(0,-boundingMin.y(),0);
    g.defaultProgram()->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix() *
        modelMatrix);

    if (drawPlugin()) drawPlugin()->drawScene();
    // Copiar colorBuffer a textura
    g.glBindTexture(GL_TEXTURE_2D, textureId);
    g.glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0, g.width(), g.height());
    g.glGenerateMipmap(GL_TEXTURE_2D);

    // Pas 2: Dibuixar escena en posició real
    g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
    g.defaultProgram()->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());
    if (drawPlugin()) drawPlugin()->drawScene();

    // Pas 3: Dibuixar quad del mirall
    program->bind();
    program->setUniformValue("colorMap", 0);
    program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());
    program->setUniformValue("width", float(g.width()));
    program->setUniformValue("height", float(g.height()));
    drawRect(g);

    program->release();
    g.glBindTexture(GL_TEXTURE_2D, 0);


    return true;
}
