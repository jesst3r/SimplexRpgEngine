﻿using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Xna.Framework.Graphics;

namespace SimplexCore
{
    public class Tileset
    {
        public Texture2D Texture { get; set; }
        public string Name { get; set; }
        public int TileSize { get; set; }
        public List<AutotileDefinition> AutotileLib { get; set; }
    }
}
