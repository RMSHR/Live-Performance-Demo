using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using MidiJack;

public class CubePosition : MonoBehaviour
{
    public MidiChannel midiChannel;
    public int knob;

    void Update()
    {
        float offset = MidiMaster.GetKnob(midiChannel, knob);

        Vector3 newPos = new Vector3(0f, offset, 0f);
        transform.position = newPos;
    }
}
