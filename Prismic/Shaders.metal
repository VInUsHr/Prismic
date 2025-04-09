//
// Shaders.metal
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
float2 perspectiveTilt(float2 position, float2 origin, float2 size, float strength) {
    float2 uv = (position - origin) / size;
    float z = 1 - strength * (1 - uv.y);

    uv.x -= 0.5;
    uv.x /= z;
    uv.x += 0.5;

    return uv * size + origin;
}

[[ stitchable ]] float2 curved(float2 position, float2 origin, float2 size, float strength) {
    float2 uv = (position - origin) / size;

    float distanceFromCenter = abs(uv.x - 0.5);
    float scaleY = 1 - (strength * distanceFromCenter * 2);

    uv.y = mix(0.5, uv.y, scaleY);

    return uv * size + origin;
}

[[ stitchable ]] float2 water(float2 position, float2 size, float time, float speed, float strength, float frequency) {
    half2 uv = half2(position / size);

    half adjustedSpeed = time * speed * 0.05h;
    half adjustedStrength = strength / 100.0h;

    uv.x += sin((uv.x + adjustedSpeed) * frequency) * adjustedStrength;
    uv.y += cos((uv.y + adjustedSpeed) * frequency) * adjustedStrength;

    return float2(uv) * size;
}

[[ stitchable ]]
half4 grayscaleGradient(float2 position, half4 color, float2 size, float timeOffset) {
    position.x *= size.x / 1200;
    float2 uv = position / size;
    float t = uv.x - timeOffset;

    half angle = t * 6.28318h;
    half3 newColor = half3(sin(angle));

    return half4(newColor * 0.5h + 0.75h, 1.0h) * color.a;
}

[[ stitchable ]]
half4 rainbowGradient(float2 position, half4 color, float2 size, float timeOffset) {
    float scaledX = position.x * (size.x / 300);
    float2 uv = float2(scaledX / size.x, position.y / size.y);
    float t = uv.x - timeOffset;

    half angle = t * 6.28318h; // 2pi

    half3 rainbow = half3(
        sin(angle),
        sin(angle + 2.094h),   // 2pi/3
        sin(angle + 4.188h)    // 4pi/3
    );

    return half4(rainbow * 0.5h + 0.5h, 1.0h) * color.a;
}
