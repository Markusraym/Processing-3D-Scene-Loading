import java.io.*;    // Needed for BufferedReader
import queasycam.*;
import controlP5.*;

QueasyCam cam;
ControlP5 cp5;
float xPos = 150;
float zPos = 300;
float speed = 1.0f;

//My variables
String lineValues[]; //The array to store all the information at first when doing line = reader.readLine();
ArrayList<Scene> objectArrayScene1 = new ArrayList<Scene>();
ArrayList<Lights> lightArrayScene1 = new ArrayList<Lights>();
ArrayList<Scene> objectArrayScene2 = new ArrayList<Scene>();
ArrayList<Lights> lightArrayScene2 = new ArrayList<Lights>();
Scene object;
Lights light;
BufferedReader reader;
String line;
PVector scene1BackgroundColor = new PVector(0, 0, 0);
PVector scene2BackgroundColor = new PVector(0, 0, 0);
int meshCount = 0;
int lightCount;
int scene1lightCount;
int scene2lightCount;
int scene1meshCount;
int scene2meshCount;
boolean scene1 = true;
boolean scene2 = false;

void setup()
{

  size(1200, 1000, P3D);
  pixelDensity(2);
  perspective(radians(60.0f), width/(float)height, 0.1, 1000);
  cp5 = new ControlP5(this);
  cp5.addButton("ChangeScene").setPosition(10, 10);
  cam = new QueasyCam(this);
  cam.speed = 0;
  cam.sensitivity = 0;
  cam.position = new PVector(0, -50, 100);

  // TODO: Load scene files here (testfile, scene 1, and scene 2)
  readFile("scene1"); //Stores everything in objectArrayScene1 and lightArrayScene1
  readFile("scene2"); //Stores everything in objectArrayScene2 and lightArrayScene2

  lights(); // Lights turned on once here
}

void draw()
{
  // Use lights, and set values for the range of lights. Scene gets REALLY bright with this commented out...
  lightFalloff(1.0, 0.001, 0.0001);
  perspective(radians(60.0f), width/(float)height, 0.1, 1000);
  pushMatrix();
  rotateZ(radians(180)); // Flip everything upside down because Processing uses -y as up

  // TODO: Draw the current scene AKA Call drawScene()
  object.DrawScene();

  popMatrix();
  camera();
  perspective();
  noLights(); // Turn lights off for ControlP5 to render correctly
  DrawText();
}

void mousePressed()
{
  if (mouseButton == RIGHT)
  {
    // Enable the camera
    cam.sensitivity = 1.0f;
    cam.speed = 2;
  }
}

void mouseReleased()
{
  if (mouseButton == RIGHT)
  {
    // "Disable" the camera by setting move and turn speed to 0
    cam.sensitivity = 0;
    cam.speed = 0;
  }
}

void ChangeScene()
{
  scene1 = !scene1; 
  scene2 = !scene2;
}

void readFile(String fileName)
{
  try //This reads the background color, meshCount, and all the object's attributes
  {
    reader = createReader("scenes/" + fileName + ".txt"); //Accesses the file depending on the string passed to the function
    line = reader.readLine();
    lineValues = line.split(",");
    if (fileName == "scene1") //If file being read is scene1, set the variables for the background color for scene1
    {
      scene1BackgroundColor.x = Integer.parseInt(lineValues[0]);
      scene1BackgroundColor.y = Integer.parseInt(lineValues[1]);
      scene1BackgroundColor.z = Integer.parseInt(lineValues[2]);
    } else if (fileName == "scene2")
    {
      scene2BackgroundColor.x = Integer.parseInt(lineValues[0]);
      scene2BackgroundColor.y = Integer.parseInt(lineValues[1]);
      scene2BackgroundColor.z = Integer.parseInt(lineValues[2]);
    }
    line = reader.readLine();
    lineValues = line.split(",");
    meshCount = Integer.parseInt(lineValues[0]);
    for (int i = 0; i < meshCount; i++)
    {
      line = reader.readLine();
      lineValues = line.split(",");
      object = new Scene();
      object.objectName = lineValues[0];
      object.location.x = Float.parseFloat(lineValues[1]);
      object.location.y = Float.parseFloat(lineValues[2]);
      object.location.z = Float.parseFloat(lineValues[3]);
      object.objectR = Integer.parseInt(lineValues[4]);
      object.objectG = Integer.parseInt(lineValues[5]);
      object.objectB = Integer.parseInt(lineValues[6]);
      //Add object to some array
      if (fileName == "scene1")
      {
        scene1meshCount = meshCount; //Set the scene1meshCount variable to meshCount if the file being accessed is scene1, so the variable can be used for the DrawText()
        objectArrayScene1.add(object);
      } else if (fileName == "scene2")
      {
        scene2meshCount = meshCount;
        objectArrayScene2.add(object);
      }
    }
    //This reads the second half, like the lightCount, and the light's attributes
    line = reader.readLine();
    lineValues = line.split(",");
    lightCount = Integer.parseInt(lineValues[0]);
    for (int i = 0; i < lightCount; i++)
    {
      line = reader.readLine();
      lineValues = line.split(",");
      light = new Lights();
      light.lightLocation.x = Integer.parseInt(lineValues[0]);
      light.lightLocation.y = Integer.parseInt(lineValues[1]);
      light.lightLocation.z = Integer.parseInt(lineValues[2]);
      light.lightR = Integer.parseInt(lineValues[3]);
      light.lightG = Integer.parseInt(lineValues[4]);
      light.lightB = Integer.parseInt(lineValues[5]);
      //Add light to some array
      if (fileName == "scene1")
      {
        scene1lightCount = lightCount;
        lightArrayScene1.add(light);
      } else if (fileName == "scene2")
      {
        scene2lightCount = lightCount;
        lightArrayScene2.add(light);
      }
    }
  }
  catch (IOException e)
  {
    e.printStackTrace();
  }
}


void DrawText()
{
  textSize(30);
  if (scene1 == true)
  {
    text("PShapes: " + scene1meshCount, 0, 60); //The values where moved down by 30 pixels because for some reason it was obscuring the change scenes button
    text("Lights: " + scene1lightCount, 0, 90);
  }
  if (scene2 == true)  
  {
    text("PShapes: " + scene2meshCount, 0, 60);
    text("Lights: " + scene2lightCount, 0, 90);
  }
}
