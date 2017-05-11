# Unity-Portals
Portal rendering in Unity by not using RenderTextures!

Instead uses ~~shader magic~~ [camera replacement shaders](https://docs.unity3d.com/Manual/SL-ShaderReplacement.html), [the stencil buffer](https://docs.unity3d.com/Manual/SL-Stencil.html) and [oblique projection](http://www.terathon.com/lengyel/Lengyel-Oblique.pdf) (thanks to [pr0g](https://github.com/pr0g/unity-portal-rendering/blob/master/PortalsWithRenderTargets/Assets/Scripts/Portal.cs) for that!).  

## Limitations:

- Requires forward rendering
- Only supports opaque object rendering using a very simple shader (diffuse map and colour)
- Does not work with skyboxes or camera background color
- No moving through the portals, yet

You can add more complicated subshaders to the World Replacement and Portal Replacement shaders.

## Controls:  

Mouse   - look around  
WASD    - move around  
E & Q   - ascend and descend  
Shift   - move faster  
Control - move slower  
End     - unlock/lock cursor  
