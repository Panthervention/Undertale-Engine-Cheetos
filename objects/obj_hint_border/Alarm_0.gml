if (Border_GetSprite() != sprite)
	Border_SetSprite(sprite, (Border_GetIndex() != index ? index : Border_GetIndex()));
