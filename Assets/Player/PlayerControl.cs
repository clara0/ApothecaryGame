using UnityEngine;

public class PlayerControl : MonoBehaviour
{

    [SerializeField] private float _speed = 5;
    private Rigidbody2D _rb;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        _rb = gameObject.GetComponent<Rigidbody2D>();
    }

    // Update is called once per frame
    void Update()
    {
        Movement();   
    }

    void Movement() {
        float horizMove = Input.GetAxis("Horizontal");
        float vertMove = Input.GetAxis("Vertical");
        transform.Translate(Vector2.right * horizMove * _speed * Time.deltaTime +
            Vector2.up * vertMove * _speed * Time.deltaTime);
    }
}
