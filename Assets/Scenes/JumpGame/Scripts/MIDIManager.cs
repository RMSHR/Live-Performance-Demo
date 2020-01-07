using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using MidiJack;

public class MIDIManager : MonoBehaviour
{
    [System.Serializable]
    public class MinMax
    {
        public float min, max;
    }

    [System.Serializable]
    public class ShaderKnobClass
    {
        public string name;
        public MinMax limits;
        public int knob;
    }

    [Header("Ground Shader")]
    public MidiChannel groundMidiChannel;
    public Material groundMaterial;
    public Renderer groundRenderer;
    public ShaderKnobClass[] groundShaderKnobs;

    [Header("Background Shader")]
    public MidiChannel backgroundMidiChannel;
    public Material backgroundMaterial;
    public Renderer backgroundRenderer;
    public ShaderKnobClass[] backgroundShaderKnobs;

    [Header("Obstacle Gameplay")]
    public MidiChannel obstacleMidiChannel;
    public int obstacleKnob;
    public GlobaleObstacleValues obstacleValues;
    public MinMax obstacleSpeed;



    void Update()
    {
        // Background Shader
        foreach (ShaderKnobClass s in backgroundShaderKnobs)
        {
            backgroundRenderer.material.SetFloat(s.name, Mathf.Lerp(
                s.limits.min,
                s.limits.max,
                MidiMaster.GetKnob(backgroundMidiChannel, s.knob)
                ));
        }

        // Ground Shader
        foreach (ShaderKnobClass s in groundShaderKnobs)
        {
            groundRenderer.material.SetFloat(s.name, Mathf.Lerp(
                s.limits.min,
                s.limits.max,
                MidiMaster.GetKnob(groundMidiChannel, s.knob)
                ));
        }

        // Obstacle GamePlay
        obstacleValues.speed = Mathf.Lerp(
            obstacleSpeed.min, 
            obstacleSpeed.max, 
            MidiMaster.GetKnob(obstacleMidiChannel, obstacleKnob)
            );
    }
}
