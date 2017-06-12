# Unity-Portals
Portal rendering in Unity by not using RenderTextures!

Instead uses ~~shader magic~~ [camera replacement shaders](https://docs.unity3d.com/Manual/SL-ShaderReplacement.html), [the stencil buffer](https://docs.unity3d.com/Manual/SL-Stencil.html) and [oblique projection](http://www.terathon.com/lengyel/Lengyel-Oblique.pdf) (thanks to [pr0g](https://github.com/pr0g/unity-portal-rendering/blob/master/PortalsWithRenderTargets/Assets/Scripts/Portal.cs) for that!).  

## Limitations:

- Requires forward rendering
- The world inside the portals is rendered using a non-standard shader (legacy bumped specular)
- Does not work with skyboxes or camera background color
- No moving through the portals, yet

You can add more subshaders to the Portal Replacement shaders for "advanced" features like transparency.

## Controls:  

Mouse   - look around  
WASD    - move around  
E & Q   - ascend and descend  
Shift   - move faster  
Control - move slower  
End     - unlock/lock cursor  
