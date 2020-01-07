using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObstacleScript : MonoBehaviour
{
    public Vector3 direction;
    public float speed = 1f;
    public float destroyBellowZ = -5f;
    GlobaleObstacleValues globaleObstacleValues;

    public void Awake()
    {
        globaleObstacleValues = GameObject.FindObjectOfType<GlobaleObstacleValues>();
        speed = globaleObstacleValues.speed;
    }

    void Update()
    {
        speed = globaleObstacleValues.speed;

        if (transform.position.z <= destroyBellowZ)
            Destroy(gameObject);

        transform.Translate(direction * speed * Time.deltaTime);
    }
}
