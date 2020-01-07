Live Performance Demo
=======

![gif](http://i.imgur.com/OFjCw9w.gif)

Live Performance Demo in Unity with midi control and fake player interactions

Rémy Sohier, 2020
Arts et Technologies de l'Image
Université Paris 8, Saint-Denis, France

[www.remysohier.com](www.remysohier.com)

Description
-------------------

This package has two scenes, some assets and scripts to demonstrate live performance for video game.
A simple scene (MidiJackTests) let you experiment basic usage of Midi to change object behaviour.
A more complexe scene (JumpGame) let you experiment a visual live modification and game live modification for performance.

Controls
-------------------
In MidiJackTests it only uses your midi hardware potentiometer (CC)
In JumpGame it also uses your midi hardware, but with more actions (on shaders)
You cna also use the keyboard to fake a game interaction with players :
* Return : reborn player
* Space : jump
* A : couch
* Pad 1 : jump obstacle
* Pad 2 : couch obstacle
* Pad 3 : impossible obstacle

Technical details
-------------------
This package has been built with Unity 2019.2.17f1

You'll need this extra package :
* [Midijack](https://github.com/keijiro/MidiJack), by Keijiro

Shaders has been scripted with [Amplify Shader Editor](https://assetstore.unity.com/packages/tools/visual-scripting/amplify-shader-editor-68570)

