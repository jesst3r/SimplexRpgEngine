﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Xml.Serialization;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using MonoGame.Extended;
using SimplexResources.Objects;
using SimplexIde;
using Color = System.Drawing.Color;
using static SimplexCore.Sgml;

namespace SimplexCore
{    
    [Serializable]
    public class GameObject : IDisposable
    {
        [XmlIgnore]
        public Sprite Sprite;
        public Vector2 Position;

        [XmlIgnore]
        public Type OriginalType;

        [XmlIgnore]
        public string[] EditorOptions = {"Send backward", "Send forward", "Delete"};

        [XmlIgnore]
        public Rectangle CollisionContainer = Rectangle.Empty;

        [XmlIgnore]
        public Control[] EditorProperties;
        /*
         * magic constants:
         * [magic_separator]
         */

        public string TypeString;


        public float ImageIndex
        {
            get => _imageIndex;
            set
            {
                _imageIndex = value;

                if (_imageIndex > FramesCount)
                {
                    _imageIndex = 0;
                }

                _imageIndex = _imageIndex.Clamp(0, FramesCount);
            }
        }

        public float ImageAngle;
        public float ImageAngleTarget;
        public float TransformSpeed;
        public Vector2 ImageScale;
        public Vector2 ImageScaleTarget;
        public float ImageAlpha;
        public string LayerName;
        public double ImageSpeed;
        public double Direction;
        public Vector2 PostionStart;
        public Vector2 PositionPrevious;
        public double Speed;
        public double Friction;
        public Vector2 Gravity;
        public Vector2 Velocity;
        public double Mass;
        public bool Persistent;
        public string PersistentLayer;
        public int alarm0 = -1;
        public int alarm1 = -1;
        public int alarm2 = -1;
        public int alarm3 = -1;
        public int alarm4 = -1;
        public int alarm5 = -1;
        public int alarm6 = -1;
        public int alarm7 = -1;
        public int alarm8 = -1;
        public int alarm9 = -1;
        public int alarm10 = -1;
        public int alarm11 = -1;
        public int alarm12 = -1;
        public int alarm13 = -1;
        public int alarm14 = -1;
        public int alarm15 = -1;
        public int alarm16 = -1;

        public int[] alarms = new[] { -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 };
        private int[] steps = new[] { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
        bool[] alarm_pause = new bool[]{ false, false, false, false, false, false, false, false, false, false,false, false, false, false, false, false };

        [XmlIgnore]
        public List<ColliderBase> Colliders = new List<ColliderBase>();

        [XmlIgnore]
        public ObjectLayer Layer;

        [XmlIgnore]
        public string EditorPath;

        [XmlIgnore]
        public int FramesCount;

        [XmlIgnore]
        public Guid Id;

        [XmlIgnore]
        public List<ColliderDescriptor> CollidersActive = new List<ColliderDescriptor>();

        private float _imageIndex;

        [XmlIgnore]
        public Vector2 TempPosition = Vector2.Zero;

        public GameObject()
        {
            ImageScale = Vector2.One;
            ImageScaleTarget = Vector2.One;
            ImageAngle = 0;
            ImageAngleTarget = 0;
            ImageIndex = 0;
            TransformSpeed = 0.2f;
            Sprite = new Sprite();
            Sprite.TextureSource = "unknown";
            ImageAlpha = 1;
            ImageSpeed = 1;
            Gravity = new Vector2(0, 270);
            Speed = 0;
            Velocity = Vector2.Zero;
            Friction = 0;
            Direction = 0;
            Id = Guid.NewGuid();
        }



        public void UpdateImageAngle()
        {
            ImageAngle = SimplexMath.Lerp(ImageAngle, ImageAngleTarget, TransformSpeed);
        }

        public void UpdateImageScale()
        {
            ImageScale = new Vector2(SimplexMath.Lerp(ImageScale.X, ImageScaleTarget.X, TransformSpeed), SimplexMath.Lerp(ImageScale.Y, ImageScaleTarget.Y, TransformSpeed));
        }

        public void UpdateColliders()
        {
            foreach (var c in Colliders)
            {
                if (c is ColliderRectangle)
                {
                    ColliderRectangle cr = c as ColliderRectangle;
                    cr.CollisionTransformed = new RectangleF(Position.X + cr.Collision.X, Position.Y + cr.Collision.Y, cr.Collision.Width, cr.Collision.Height);
                }

                if (c is ColliderCircle)
                {
                    ColliderCircle cr = c as ColliderCircle;
                    cr.Position = new Vector2(Position.X, Position.Y);            
                }
            }
        }

        public void RegisterCollider(string c, Type cT, string n, Action<GameObject, GameObject> method)
        {
            CollisionPairExtended cp1 = new CollisionPairExtended();
            CollisionPair cp2 = new CollisionPair();

            cp1.ColliderName = c;
            cp1.Object = GetType();
            cp1.CollisionAction = method;

            cp2.ColliderName = n;
            cp2.Object = cT;

            
            CollisionsTree.DefinedCollisionPairs.Add(cp1, cp2);
        }

        public void DrawStart(SpriteBatch s, DynamicVertexBuffer vb, BasicEffect be, Matrix m, GameObject currentObject)
        {
            Sgml.sb = s;
            Sgml.vb = vb;
            Sgml.be = be;
            Sgml.m = m;
            Sgml.currentObject = currentObject;
        }

        // Editor events
        public virtual void EvtRegisterCollisions()
        {

        }

        public virtual void EvtDraw()
        {
            //s.Draw(objectTexture, Position, Microsoft.Xna.Framework.Color.White * ImageAlpha);
        }

        public virtual void EvtCreate()
        {
            
        }

        public virtual void EvtCreateEnd()
        {

        }

        public virtual void EvtLoad()
        {

        }

        public virtual void EvtSave()
        {

        }

        public virtual void EvtDelete()
        {

        }

        public virtual void EvtStep()
        {

        }

        public virtual void EvtContextMenuSelected(ToolStripItem e)
        {

        }

        public virtual void EvtDrawToSurfaces()
        {

        }

        public virtual void EvtAlarm0()
        {
            
        }
        
        public virtual void EvtAlarm1()
        {
            
        }
        
        public virtual void EvtAlarm2()
        {
            
        }
        
        public virtual void EvtAlarm3()
        {
            
        }
        
        public virtual void EvtAlarm4()
        {
            
        }
        
        public virtual void EvtAlarm5()
        {
            
        }
        
        public virtual void EvtAlarm6()
        {
            
        }
        
        public virtual void EvtAlarm7()
        {
            
        }
        
        public virtual void EvtAlarm8()
        {
            
        }
        
        public virtual void EvtAlarm9()
        {
            
        }
        
        public virtual void EvtAlarm10()
        {
            
        }
        
        public virtual void EvtAlarm11()
        {
            
        }
        
        public virtual void EvtAlarm12()
        {
            
        }
        
        public virtual void EvtAlarm13()
        {
            
        }
        
        public virtual void EvtAlarm14()
        {
            
        }
        
        public virtual void EvtAlarm15()
        {
            
        }
        
        public virtual void EvtAlarm16()
        {
            
        }

        // Public state events  
        public void UpdateState()
        {
            for (int i = 0; i < 16; i++)
            {
                
                    if (alarms[i] > 0)
                    {
                        alarms[i]--;
                    }
                    else if (alarms[i] == 0)
                    {
                        switch (alarms[i])
                        {
                            case 0:
                                EvtAlarm0();
                                break;
                            case 1:
                                EvtAlarm1();
                                break;
                            case 2:
                                EvtAlarm2();
                                break;
                            case 3:
                                EvtAlarm3();
                                break;
                            case 4:
                                EvtAlarm4();
                                break;
                            case 5:
                                EvtAlarm5();
                                break;
                            case 6:
                                EvtAlarm6();
                                break;
                            case 7:
                                EvtAlarm7();
                                break;
                            case 8:
                                EvtAlarm8();
                                break;
                            case 9:
                                EvtAlarm9();
                                break;
                            case 10:
                                EvtAlarm10();
                                break;
                            case 11:
                                EvtAlarm11();
                                break;
                            case 12:
                                EvtAlarm12();
                                break;
                            case 13:
                                EvtAlarm13();
                                break;
                            case 14:
                                EvtAlarm14();
                                break;
                            case 15:
                                EvtAlarm15();
                                break;
                            case 16:
                                EvtAlarm16();
                                break;
                        }
                        alarms[i] = -1;
                    }
                }

            UpdateImageScale();
            UpdateImageAngle();

            ImageIndex += (float)ImageSpeed;
            // Apply friction
            if (abs(Speed) > 0)
            {
                if (Speed > 0)
                {
                    Speed -= Friction;
                }
                else
                {
                    Speed += Friction;
                }

                if (abs(Speed) < Friction)
                {
                    Speed = 0;
                }
            }
            // Update velocity
            Velocity = new Vector2(Velocity.X + (float)lengthdir_x(-Gravity.X, Gravity.Y), Velocity.Y + (float)lengthdir_y(-Gravity.X, Gravity.Y));

            Position = new Vector2(Position.X + Velocity.X + (float)lengthdir_x(Speed, Direction), Position.Y + Velocity.Y + (float)lengthdir_y(Speed, Direction));
        }


        // Events
        public virtual void OnCreate()
        {

        }

        public virtual void OnStep()
        {

        }

        public virtual void OnDraw(SpriteBatch sb)
        {
           
        }

        #region IDisposable Support
        private bool disposedValue = false; // To detect redundant calls

        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    // TODO: dispose managed state (managed objects).
                }

                // TODO: free unmanaged resources (unmanaged objects) and override a finalizer below.
                // TODO: set large fields to null.

                disposedValue = true;
            }
        }

        // TODO: override a finalizer only if Dispose(bool disposing) above has code to free unmanaged resources.
        // ~GameObject() {
        //   // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
        //   Dispose(false);
        // }

        // This code added to correctly implement the disposable pattern.
        public void Dispose()
        {
            // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
            Dispose(true);
            // TODO: uncomment the following line if the finalizer is overridden above.
            // GC.SuppressFinalize(this);
        }
        #endregion
    }
}
