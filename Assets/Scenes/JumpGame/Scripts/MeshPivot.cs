using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshPivot : MonoBehaviour
{
    public PlayerScript script;
    public Vector3 standRotation, couchRotation;
    public float changeRotationSpeed = 1f;

    void Update()
    {
        Vector3 newRotation = standRotation;

        if(script.isCouching)
        {
            newRotation = couchRotation;
        }

        transform.rotation = Quaternion.Lerp(
            transform.rotation,
            Quaternion.Euler(newRotation),
            Time.deltaTime * changeRotationSpeed);
    }
}
