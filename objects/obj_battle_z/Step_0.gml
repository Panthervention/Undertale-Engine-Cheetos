hspeed = 1;
siner += 0.5;
x += sin((siner / 8));
y += cos((siner / 8));
if (image_xscale < 1)
    image_xscale += 0.02;
if (image_yscale < 1)
    image_yscale += 0.02;
if (siner > 120)
{
    image_alpha -= 0.05;
    if (image_alpha < 0.05)
        instance_destroy();
}
