using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObstacleGenerator : MonoBehaviour
{
    public ObstacleObject[] obstacles;
    public Vector3 startPosition;

    void Update()
    {
        foreach (ObstacleObject o in obstacles)
        { 
            if (Input.GetKeyDown(o.key))
            {
                Instantiate(o.prefab, startPosition, o.prefab.transform.rotation);
            }
        }
    }
}

[System.Serializable]
public class ObstacleObject
{
    public KeyCode key;
    public GameObject prefab;
}
