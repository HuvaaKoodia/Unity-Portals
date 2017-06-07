using UnityEngine;

[SelectionBase]
public class Portal : MonoBehaviour
{
    #region vars
    public Camera mainCamera;
    public Portal target;
    public Camera portalCamera;
    public Transform projectionCenter;
    #endregion
    #region init
    private void Start()
    {
        if (!target)
            Debug.LogErrorFormat("Portal {0} has no Target", gameObject.name);
    }
    #endregion
    #region logic
    Quaternion QuaternionFromMatrix(Matrix4x4 m) { return Quaternion.LookRotation(m.GetColumn(2), m.GetColumn(1)); }
    Vector4 PosToV4(Vector3 v) { return new Vector4(v.x, v.y, v.z, 1.0f); }
    Vector3 ToV3(Vector4 v) { return new Vector3(v.x, v.y, v.z); }

    public void LateUpdate()
    {
        //change portal camera depth values to make sure that the correct camera is rendered on top
        float distance = Vector3.Distance(mainCamera.transform.position, transform.position);
        float distance2 = Vector3.Distance(mainCamera.transform.position, target.transform.position);
        
        portalCamera.depth = distance < distance2 ? -1 : -2;

        // The rotation and projection code taken from: https://github.com/pr0g/unity-portal-rendering/tree/master
        // Thanks a lot pr0g!

        // Rotate portal camera 180 degrees so that it is a mirror image of the main camera
        Matrix4x4 targetFlipRotation = Matrix4x4.TRS(Vector3.zero, Quaternion.AngleAxis(180.0f, Vector3.up), Vector3.one);
        Matrix4x4 inversionMatrix = targetFlipRotation * transform.worldToLocalMatrix;

        // Calculate translation and rotation of main camera in current space
        Vector3 cameraPositionInSourceSpace = ToV3(inversionMatrix * PosToV4(mainCamera.transform.position));
        Quaternion cameraRotationInSourceSpace = QuaternionFromMatrix(inversionMatrix) * mainCamera.transform.rotation;

        // Transform portal camera to world space relative to target transform,
        // matching the main camera position & orientation
        portalCamera.transform.position = target.transform.TransformPoint(cameraPositionInSourceSpace);
        portalCamera.transform.rotation = target.transform.rotation * cameraRotationInSourceSpace;

        // Calculate clip plane for portal (for culling of objects inbetween target camera and portal)
        var targetProjectionCenter = target.projectionCenter;
        Vector4 clipPlaneWorldSpace = new Vector4(targetProjectionCenter.forward.x, targetProjectionCenter.forward.y, targetProjectionCenter.forward.z, Vector3.Dot(targetProjectionCenter.position, -targetProjectionCenter.forward));
            Vector4 clipPlaneCameraSpace = Matrix4x4.Transpose(Matrix4x4.Inverse(portalCamera.worldToCameraMatrix)) * clipPlaneWorldSpace;

        // Update projection based on new clip plane
        // Note: http://aras-p.info/texts/obliqueortho.html and http://www.terathon.com/lengyel/Lengyel-Oblique.pdf
        portalCamera.projectionMatrix = mainCamera.CalculateObliqueMatrix(clipPlaneCameraSpace);

    }
    #endregion
    #region public interface
    #endregion
    #region private interface
    #endregion
    #region events
    #endregion
}
