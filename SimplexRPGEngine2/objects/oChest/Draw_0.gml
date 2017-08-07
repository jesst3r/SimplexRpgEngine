/// @desc [Simplex description line]

if (libUtilityCheckCollisionRect(v_collisionMain, oPlayer.v_collisionLegs))
{
	if (keyboard_check_pressed(ord("E")) && oPlayer.v_lastDir == e_dirs.valW)
	{
		if (!v_openMode)
		{
			v_openMode = 1;
			v_playAnimation = 1;
			image_speed = 0.4;
		}
		else
		{
			v_openMode = 0;
		}
	}
	
	if (oPlayer.v_lastDir == e_dirs.valW) {v_actionAlpha = lin(v_actionAlpha, 1, 0.1);} 
	else {v_actionAlpha = lin(v_actionAlpha, 0, 0.1);}
}
else
{
	v_openMode = 0;
	v_actionAlpha = lin(v_actionAlpha, 0, 0.1);
}

if (!v_openMode)
{
	image_speed = -0.4;
	v_fadeAlpha = lin(v_fadeAlpha, 0, 0.1);
}
else
{
	v_fadeAlpha = lin(v_fadeAlpha, 1, 0.1);
}

if (v_actionAlpha > 0.05)
{
	if (oPlayer.v_lastDir == e_dirs.valW)
	{
		var tmp_string;
		if (v_openMode && libUtilityCheckCollisionRect(v_collisionMain, oPlayer.v_collisionLegs)) {tmp_string = __("close");}
		else {tmp_string = __("open");}
		v_lastString = tmp_string;
	}
	
	libDrawTextStylized(x + 16, y - 16, _sc("E", c_yellow) + " - " + v_lastString, v_actionAlpha);

	if (v_fadeAlpha > 0.05)
	{		
		var tmp_drawX, tmp_drawY, tmp_currentRow, tmp_slotsRenderedNow, tmp_offsetHelp, tmp_actualSlot, tmp_hover, tmp_hovered;
		tmp_drawX = x + 16 - (((oInventory.v_slotSize + 6) * v_slotsPerRow) / 2);
		tmp_drawY = y - ((oInventory.v_slotSize + 6) * v_slotRows) - 32;
		tmp_currentRow = 0;
		tmp_slotsRenderedNow = 0;
		tmp_actualSlot = 0;
		tmp_lastHover = -1;	
		tmp_hovered = false;
	
		for (var i = 0; i < v_slots; i++)
		{
				clr(-1, min(v_fadeAlpha, v_actionAlpha));
				
				tmp_hover = false;
				tmp_offsetHelp = oHUD.v_hudSlotX;
				
				if (point_in_rectangle(mouse_x, mouse_y, tmp_drawX, tmp_drawY, tmp_drawX + 36, tmp_drawY + 36))
				{
					tmp_hover = true;
					tmp_offsetHelp = oHUD.v_hudSlotUseX;
					tmp_lastHover = tmp_actualSlot;
					if (v_slot[tmp_actualSlot, e_inventoryAtributes.valID] != e_items.valNONE) { v_lastHover = tmp_actualSlot; tmp_hovered = true;}
					if (oInventory.v_slotBeingDragged != -1) {oInventory.v_containerID = id;}
				}	
				
				cpInventoryHelperHandleInput(id, i, tmp_hover);
				
				if (tmp_currentRow == 0)
				{
					if (tmp_slotsRenderedNow == 0)
					{
						draw_sprite_part(oInventory.v_inventorySprite, 0, tmp_offsetHelp, oHUD.v_hudSlotY, 38, 38, tmp_drawX, tmp_drawY);
					}
					else if (tmp_slotsRenderedNow == v_slotsPerRow - 1)
					{
						draw_sprite_part(oInventory.v_inventorySprite, 0, tmp_offsetHelp + 76, oHUD.v_hudSlotY, 38, 38, tmp_drawX, tmp_drawY);		
					}
					else
					{
						draw_sprite_part(oInventory.v_inventorySprite, 0, tmp_offsetHelp + 38, oHUD.v_hudSlotY, 38, 38, tmp_drawX, tmp_drawY);
					}
				}
				else if (tmp_currentRow == (v_slotRows - 1))
				{
					if (tmp_slotsRenderedNow == 0)
					{
						draw_sprite_part(oInventory.v_inventorySprite, 0, tmp_offsetHelp, oHUD.v_hudSlotY + 76, 38, 38, tmp_drawX, tmp_drawY);
					}
					else if (tmp_slotsRenderedNow == v_slotsPerRow - 1)
					{
						draw_sprite_part(oInventory.v_inventorySprite, 0, tmp_offsetHelp + 76, oHUD.v_hudSlotY + 76, 38, 38, tmp_drawX, tmp_drawY);		
					}
					else
					{
						draw_sprite_part(oInventory.v_inventorySprite, 0, tmp_offsetHelp + 38, oHUD.v_hudSlotY + 76, 38, 38, tmp_drawX, tmp_drawY);
					}
				}
				else
				{
					if (tmp_slotsRenderedNow == 0)
					{
						draw_sprite_part(oInventory.v_inventorySprite, 0, tmp_offsetHelp, oHUD.v_hudSlotY + 38, 38, 38, tmp_drawX, tmp_drawY);
					}
					else if (tmp_slotsRenderedNow == v_slotsPerRow - 1)
					{
						draw_sprite_part(oInventory.v_inventorySprite, 0, tmp_offsetHelp + 76, oHUD.v_hudSlotY + 38, 38, 38, tmp_drawX, tmp_drawY);		
					}
					else
					{
						draw_sprite_part(oInventory.v_inventorySprite, 0, tmp_offsetHelp + 38, oHUD.v_hudSlotY + 38, 38, 38, tmp_drawX, tmp_drawY);
					}
				}		
				
				//draw_text(tmp_drawX - 16, tmp_drawY, string(i));				
				
				// Draw item
				if (v_slot[i, e_inventoryAtributes.valID] != 0 && v_slotBeingDragged != i)
				{		
					if (v_slot[i, e_inventoryAtributes.valLerpColor] != 0)
					{
						shader_set(shdLerp);
						var tmp_uID = shader_get_uniform(shdLerp, "f_Colour1");
						shader_set_uniform_f(tmp_uID, color_get_red(v_slot[i, e_inventoryAtributes.valLerpColor]), color_get_green(v_slot[i, e_inventoryAtributes.valLerpColor]), color_get_blue(v_slot[i, e_inventoryAtributes.valLerpColor]), v_actualLerp);
					}
					draw_sprite_ext(v_slot[i, e_inventoryAtributes.valSprite], v_slot[i, e_inventoryAtributes.valImageIndex] + 2, tmp_drawX + 20, tmp_drawY + 20, 1, 1, 0, c_white, min(v_fadeAlpha, v_actionAlpha));		
					shader_reset();
					
					var tmp_drawColor, tmp_drawOffsetX;
					tmp_drawColor = c_white;
					tmp_drawOffsetX = 0; 
		
					if (v_slot[tmp_actualSlot, e_inventoryAtributes.valStackable])
					{
						if (v_slot[tmp_actualSlot, e_inventoryAtributes.valCurrentStackSize] == v_slot[tmp_actualSlot, e_inventoryAtributes.valMaxStackSize]) 
						{
							tmp_drawColor = c_yellow;
						}
			
						if (v_slot[tmp_actualSlot, e_inventoryAtributes.valCurrentStackSize] >= 1000)
						{
							tmp_drawOffsetX = 12;
						}			
						else if (v_slot[tmp_actualSlot, e_inventoryAtributes.valCurrentStackSize] >= 100)
						{
							tmp_drawOffsetX = 8;
						}
						else if (v_slot[tmp_actualSlot, e_inventoryAtributes.valCurrentStackSize] >= 10)
						{
							tmp_drawOffsetX = 4;
						}
			
						fnt(fntPixelSmall);
						clr(tmp_drawColor, min(v_fadeAlpha, v_actionAlpha));
						draw_text(tmp_drawX + 16 - tmp_drawOffsetX + 6, tmp_drawY + 32 - 10, string(v_slot[tmp_actualSlot, e_inventoryAtributes.valCurrentStackSize]));
						clr(c_black, min(v_fadeAlpha, v_actionAlpha));
					}					
			}
			
			tmp_actualSlot++;		
			tmp_slotsRenderedNow++;
			if (tmp_slotsRenderedNow >= v_slotsPerRow)
			{
				tmp_drawX = x + 16 - (((oInventory.v_slotSize + 6) * v_slotsPerRow) / 2);
				tmp_drawY += oInventory.v_slotSize + 6;
				tmp_slotsRenderedNow = 0;
				tmp_currentRow++;
			}
			else
			{
				tmp_drawX += oInventory.v_slotSize + 6;
			}			
		}
		
		if (tmp_hovered) {v_hoverAlpha = lerp(v_hoverAlpha, 1, 0.1); v_hoverAlphaFF = 3;}
		else {if (v_hoverAlphaFF > 0) {v_hoverAlphaFF--;} else {v_hoverAlpha = lerp(v_hoverAlpha, 0, 0.1);}}
		
		if (v_hoverAlpha > 0)
		{
			v_formAlpha = min(v_fadeAlpha, v_actionAlpha);
			cpInventoryHelperDrawInfobox(id);
		}
		
		// Check for item release
		if (v_slotBeingDragged != -1)
		{
			if (mouse_check_button_released(mb_left))
			{
				// If we hover over any item switch them
				if (tmp_lastHover != -1)
				{
					var tmp_switchDone, tmp_itemsSwitched;
					tmp_switchDone = true;
					tmp_itemsSwitched = 0;
			
					// We try to join item slots if they have the same id and are stackable
					if (v_slot[tmp_lastHover, e_inventoryAtributes.valID] == v_slot[v_slotBeingDragged, e_inventoryAtributes.valID] && v_slot[tmp_lastHover, e_inventoryAtributes.valStackable] && v_slot[v_slotBeingDragged, e_inventoryAtributes.valStackable])
					{			
						repeat(v_slot[v_slotBeingDragged, e_inventoryAtributes.valCurrentStackSize])
						{
							if (v_slot[tmp_lastHover, e_inventoryAtributes.valCurrentStackSize] < v_slot[tmp_lastHover, e_inventoryAtributes.valMaxStackSize])
							{
								v_slot[tmp_lastHover, e_inventoryAtributes.valCurrentStackSize]++;
								v_slot[v_slotBeingDragged, e_inventoryAtributes.valCurrentStackSize]--;
								tmp_itemsSwitched++;
						
								if (v_slot[v_slotBeingDragged, e_inventoryAtributes.valCurrentStackSize] <= 0)
								{
									cpInventoryHelperClearSlot(v_slotBeingDragged, id);
									break;
								}
							}
							else
							{
								tmp_switchDone = false;
							}
						}
					}
					else
					{
						tmp_switchDone = false;
					}
			
					if (!tmp_switchDone && tmp_itemsSwitched == 0)
					{
						var tmp_atrb, tmp_prop, tmp_req;
						for (var k = 0; k <= mcInvenotryAtributes; k++)
						{
							tmp_atrb[k] = v_slot[v_slotBeingDragged, k];			
						}
				
						for (var k = 0; k < mcInventoryProperties; k++)
						{
							tmp_prop[k] = v_slotProperty[v_slotBeingDragged, k];	
							tmp_req[k] = v_slotReq[v_slotBeingDragged, k];
						}
				
						for (var k = 0; k <= mcInvenotryAtributes; k++)
						{
							v_slot[v_slotBeingDragged, k] = v_slot[tmp_lastHover, k];					
							v_slot[tmp_lastHover, k] = tmp_atrb[k];
						}
			
						for (var k = 0; k < mcInventoryProperties; k++)
						{
							v_slotProperty[v_slotBeingDragged, k] = v_slotProperty[tmp_lastHover, k];
							v_slotProperty[tmp_lastHover, k] = tmp_prop[k];
					
							v_slotReq[v_slotBeingDragged, k] = v_slotReq[tmp_lastHover, k];
							v_slotReq[tmp_lastHover, k] = tmp_req[k];					
						}
					}	
				}
				
				if (oInventory.tmp_lastHover != -1)
				{
					var tmp_switchDone, tmp_itemsSwitched;
					tmp_switchDone = true;
					tmp_itemsSwitched = 0;
			
					// We try to join item slots if they have the same id and are stackable
					if (oInventory.v_slot[oInventory.tmp_lastHover, e_inventoryAtributes.valID] == v_slot[v_slotBeingDragged, e_inventoryAtributes.valID] && oInventory.v_slot[oInventory.tmp_lastHover, e_inventoryAtributes.valStackable] && v_slot[v_slotBeingDragged, e_inventoryAtributes.valStackable])
					{			
						repeat(v_slot[v_slotBeingDragged, e_inventoryAtributes.valCurrentStackSize])
						{
							if (oInventory.v_slot[oInventory.tmp_lastHover, e_inventoryAtributes.valCurrentStackSize] < oInventory.v_slot[oInventory.tmp_lastHover, e_inventoryAtributes.valMaxStackSize])
							{
								oInventory.v_slot[oInventory.tmp_lastHover, e_inventoryAtributes.valCurrentStackSize]++;
								v_slot[v_slotBeingDragged, e_inventoryAtributes.valCurrentStackSize]--;
								tmp_itemsSwitched++;
						
								if (v_slot[v_slotBeingDragged, e_inventoryAtributes.valCurrentStackSize] <= 0)
								{
									cpInventoryHelperClearSlot(v_slotBeingDragged, id);
									break;
								}
							}
							else
							{
								tmp_switchDone = false;
							}
						}
					}
					else
					{
						tmp_switchDone = false;
					}
			
					if (!tmp_switchDone && tmp_itemsSwitched == 0)
					{
						var tmp_atrb, tmp_prop, tmp_req;
						for (var k = 0; k <= mcInvenotryAtributes; k++)
						{
							tmp_atrb[k] = v_slot[v_slotBeingDragged, k];			
						}
				
						for (var k = 0; k < mcInventoryProperties; k++)
						{
							tmp_prop[k] = v_slotProperty[v_slotBeingDragged, k];	
							tmp_req[k] = v_slotReq[v_slotBeingDragged, k];
						}
				
						for (var k = 0; k <= mcInvenotryAtributes; k++)
						{
							v_slot[v_slotBeingDragged, k] = oInventory.v_slot[oInventory.tmp_lastHover, k];					
							oInventory.v_slot[oInventory.tmp_lastHover, k] = tmp_atrb[k];
						}
			
						for (var k = 0; k < mcInventoryProperties; k++)
						{
							v_slotProperty[v_slotBeingDragged, k] = oInventory.v_slotProperty[oInventory.tmp_lastHover, k];
							oInventory.v_slotProperty[oInventory.tmp_lastHover, k] = tmp_prop[k];
					
							v_slotReq[v_slotBeingDragged, k] = oInventory.v_slotReq[oInventory.tmp_lastHover, k];
							oInventory.v_slotReq[oInventory.tmp_lastHover, k] = tmp_req[k];					
						}
					}	
				}
				
				oHUD.v_mouseFree = true;
				v_slotBeingDragged = -1;
			}
		}
		
		// Draw dragged item
		if (v_slotBeingDragged != -1)
		{
			oDrawHelperAbove.v_id = id;
			oDrawHelperAbove.v_mode = 0;
		}
		
		// Draw item in mouse
		if (v_itemMouse != -1)
		{
			oDrawHelperAbove.v_id = id;
			oDrawHelperAbove.v_mode = 1;
		}		
	}
}
else
{
	v_openMode = 0;
}

clr();
libUtilityDrawRect(v_collisionMain);
draw_self();

if (v_lerpMode == 0) {v_actualLerp = lin(v_actualLerp, 0.01, 0.00005); if (v_actualLerp >= 0.003) {v_lerpMode = 1;}}
if (v_lerpMode == 1) {v_actualLerp = lin(v_actualLerp, 0, 0.00005); if (v_actualLerp <= 0.0003) {v_lerpMode = 0;}}