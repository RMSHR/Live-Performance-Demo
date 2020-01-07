using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerScript : MonoBehaviour
{
    public float jumpForce = 500f;
    public bool isCouching = false;
    public float delayBeforeStand = .5f;
    Rigidbody _rigidBody;

    public KeyCode jumpKey = KeyCode.Space;
    public KeyCode couchKey = KeyCode.A;
    public KeyCode rebornKey = KeyCode.Return;

    bool isGrounded = true;
    bool isDead = true;

    public GameObject deathParticle;
    public GameObject rebornParticle;
    public GameObject meshGameObject;

    public AudioClip clipReborn, clipDie, clipJump;
    AudioSource _audioSource;

    private void Awake()
    {
        _rigidBody = GetComponent<Rigidbody>();
        _audioSource = GetComponent<AudioSource>();
    }

    private void Update()
    {
        if(Input.GetKeyDown(rebornKey))
        {
            Reborn();
        }

        if (isDead)
            return;

        // GAMEPLAY

        if(Input.GetKeyDown(jumpKey) && isGrounded)
        {
            Jump();
        }

        if (Input.GetKeyDown(couchKey))
        {
            isCouching = true;
        }

        if (Input.GetKeyUp(couchKey))
        {
            isCouching = false;
        }
    }

    public void Reborn()
    {
        _audioSource.PlayOneShot(clipReborn);
        meshGameObject.SetActive(true);
        GameObject g = Instantiate(rebornParticle)as GameObject;
        g.transform.position = transform.position;
        isDead = false;
    }

    public void Die()
    {
        _audioSource.PlayOneShot(clipDie);
        meshGameObject.SetActive(false);
        GameObject g = Instantiate(deathParticle) as GameObject;
        g.transform.position = transform.position;
        isDead = true;
    }

    private void OnTriggerEnter(Collider other)
    {
        if(!isDead) Die();
    }

    private void OnCollisionEnter(Collision collision)
    {
        isGrounded = true;
    }

    private void OnCollisionExit(Collision collision)
    {
        isGrounded = false;
    }

    public void Jump()
    {
        _audioSource.PlayOneShot(clipJump);
        _rigidBody.AddForce(Vector3.up * jumpForce);
    }

    public void Couch()
    {
        Debug.Log("Couch");
        isCouching = true;
    }
}
