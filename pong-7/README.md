# pong-7 (Collision update)

# AABB Collision Detection

Relies on all colliding entities to have `axis-aligned bounding boxes`, which means their collision boxes contain no rotation in our world space, which allows us to use a simple math formula to test for collision

https://developer.mozilla.org/en-US/docs/Games/Techniques/3D_collision_detection

We need to do collision test for each axis, using the boxes boundaries

```Lua
function collision(A, B)
    return hasAxisCollision(A.x, A.x + A.width, B.x, B.x + B.width) and
        hasAxisCollision(A.y, A.y + A.height, B.y, B.y + B.height)
end

function hasAxisCollision(A1, A2, B1, B2)
    Amax = math.max(A1, A2)
    Amin = math.min(A1, A2)
    Bmax = math.max(B1, B2)
    Bmin = math.min(B1, B2)
    return Amin <= Bmax and Amax >= Bmin
end
```

Coding Math: Episode 14 - Collision Detection: https://www.youtube.com/watch?v=NZHzgXFKfuY
