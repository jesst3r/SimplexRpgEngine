/// @description Insert description here
// You can write your code in this editor

v_collisionMain	    = [x + sprite_get_bbox_left(sprite_index), y + sprite_get_bbox_top(sprite_index), x + sprite_get_bbox_right(sprite_index), y + sprite_get_bbox_bottom(sprite_index)];
v_collisionLegs	    = [-1, -1, -1, -1];
v_canCollide		= true;
v_staticDepth		= false;
v_canBeDamaged		= false;
v_alive				= true;
v_isVivid			= false;
v_isMask			= false;
v_dropShardsOnHit	= false;
v_reflIndex         = 0;
v_reflOffset        = 0;
v_reflSprite        = -1;
v_reflImageIndex    = -1;