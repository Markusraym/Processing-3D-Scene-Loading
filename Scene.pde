class Scene
{

  String objectName;
  PVector location = new PVector(0, 0, 0);
  int objectR;
  int objectG;
  int objectB;   
  //add this
  ArrayList<Scene> objectArray = new ArrayList<Scene>();
  ArrayList<Lights> lightArray = new ArrayList<Lights>();
  void DrawScene()
  {
    // TODO: Draw all the information in this scene
    if (scene1 == true) //Draw everything for scene1
    {
      background(scene1BackgroundColor.x, scene1BackgroundColor.y, scene1BackgroundColor.z);
      for (int i = 0; i < lightArrayScene1.size(); i++)
      {
        pointLight(lightArrayScene1.get(i).lightR, lightArrayScene1.get(i).lightG, lightArrayScene1.get(i).lightB, lightArrayScene1.get(i).lightLocation.x, lightArrayScene1.get(i).lightLocation.y, lightArrayScene1.get(i).lightLocation.z);
      }

      for (int i = 0; i < objectArrayScene1.size(); i++)
      {
        pushMatrix();
        translate(objectArrayScene1.get(i).location.x, objectArrayScene1.get(i).location.y, objectArrayScene1.get(i).location.z);
        PShape object = loadShape("models/" + objectArrayScene1.get(i).objectName + ".obj");
        object.setFill(color(objectArrayScene1.get(i).objectR, objectArrayScene1.get(i).objectG, objectArrayScene1.get(i).objectB));
        shape(object);
        popMatrix();
      }
    }
    if (scene2 == true) //Draw everything for scene1
    {
      background(scene2BackgroundColor.x, scene2BackgroundColor.y, scene2BackgroundColor.z);
      for (int i = 0; i < lightArrayScene2.size(); i++)
      {
        pointLight(lightArrayScene2.get(i).lightR, lightArrayScene2.get(i).lightG, lightArrayScene2.get(i).lightB, lightArrayScene2.get(i).lightLocation.x, lightArrayScene2.get(i).lightLocation.y, lightArrayScene2.get(i).lightLocation.z);
      }

      for (int i = 0; i < objectArrayScene2.size(); i++)
      {
        pushMatrix();
        translate(objectArrayScene2.get(i).location.x, objectArrayScene2.get(i).location.y, objectArrayScene2.get(i).location.z);
        PShape object = loadShape("models/" + objectArrayScene2.get(i).objectName + ".obj");
        object.setFill(color(objectArrayScene2.get(i).objectR, objectArrayScene2.get(i).objectG, objectArrayScene2.get(i).objectB));
        shape(object);
        popMatrix();
      }
    }
  }
}
