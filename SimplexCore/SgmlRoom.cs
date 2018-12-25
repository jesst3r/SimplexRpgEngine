﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using SimplexIde;

namespace SimplexCore
{
    public static partial class Sgml
    {

        public static void room_goto(Type room)
        {
            // First (again) but I've tackled down later
            // we 
            // need
            // to 
            // weed... no! We need to check if current room is persistent
            // and if that's the case well then boy.. we gonna create a shadow copy of it
            // saving state of it for later (overwrite if needed

            // R u persistent madafaka?
            if (currentRoom != null && currentRoom.Persistent)
            {
                // Save teh bitch
                game_save("temp_" + currentRoom.GetType().ToString().Split('.').Last() + ".sav");
            }

            // Now we check if the next room is persistent
            // true --> load shadow copy of that room if it exists, otherwise create it from an actual copy
            // false --> load common copy 

            // Instantiate that room to see what's inside
            GameRoom tempRoom = (GameRoom)Activator.CreateInstance(room);

            // Store persistent objects
            List<GameObject> persistentObjects = SceneObjects.Where(x => x.Persistent).ToList();

            if (tempRoom.Persistent)
            {
                // TODO
            }
            else
            {
                Form1.activeRoom =  RoomEditor.roomsControl.dtv.Nodes[0].Nodes.FirstOrDefault(x => x.Text == tempRoom.GetType().ToString().Split('.').Last());
                RoomEditor.editorForm.setStatusBottom("Editing " + Form1.activeRoom.Text);

                //game_save(Path.Combine(Environment.CurrentDirectory, @"Data/" + currentRoom.GetType().ToString().Split('.').Last()));
                game_load(Path.Combine(Environment.CurrentDirectory, @"Data/" + tempRoom.GetType().ToString().Split('.').Last()));
                RoomEditor.currentRoom = tempRoom;
                roomLayers = RoomEditor.currentRoom.Layers;

                // Also we need to assign them all to appropriate layers
                foreach (GameObject go in persistentObjects)
                {
                    go.Layer = (RoomEditor.currentRoom.Layers[0] as ObjectLayer);

                    go.LayerName = go.Layer.Name;
                    go.Layer.Objects.Add(go);
                    sh.RegisterObject(go);
                }

                SceneObjects.AddRange(persistentObjects);

            }


        }
    }
}