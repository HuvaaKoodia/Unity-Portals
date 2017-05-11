using UnityEngine;

public class CameraReplacementShader : MonoBehaviour
{
    public Shader shader;

    void Start()
    {
        GetComponent<Camera>().SetReplacementShader(shader, "RenderType");
    }
}
