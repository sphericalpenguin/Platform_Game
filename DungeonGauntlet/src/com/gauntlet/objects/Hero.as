package com.gauntlet.objects
{
	import flash.display.Sprite;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * The hero for the game.
	 * 
	 * @author Casey Sliger
	 */
	public class Hero extends FlxSprite
	{
		[Embed(source = "../../../../embeded_resources/hero.png")] private static var ImgHero:Class;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the Hero object.
		 * 
		 * @param	X				The initial X position of the sprite.
		 * @param	Y				The initial Y position of the sprite.
		 * @param	SimpleGraphic	The graphic you want to display (OPTIONAL - for simple stuff only, do NOT use for animated images!).
		 */
		public function Hero(X:Number=0,Y:Number=0,SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			this.loadGraphic(ImgHero, true, true, 32);
			
			//bounding box tweaks
			this.width = 30;
			this.height = 30;
			this.offset.x = 1;
			this.offset.y = 1;
			
			//basic player physics
			this.drag.x = 640;
			this.acceleration.y = 420;
			this.maxVelocity.x = 80;
			this.maxVelocity.y = 200;
			
			//animations
			this.addAnimation("idle", [0]);
			this.addAnimation("run", [1, 2, 3, 0], 12);
			this.addAnimation("jump", [4]);
		}
		
		/**
		 * Called every frame.
		 * Update the Hero's position and other stuff.
		 */
		override public function update():void
		{
			//input for movement
			this.acceleration.x = 0;
			
			if(FlxG.keys.A)
			{
				this.facing = FlxObject.LEFT;
				this.acceleration.x -= this.drag.x;
			}
			else if(FlxG.keys.D)
			{
				this.facing = FlxObject.RIGHT;
				this.acceleration.x += this.drag.x;
			}
			if((FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("W"))&& this.velocity.y == 0)
			{
				this.y -= 1;
				this.velocity.y = -1500;
			}
			
			//animate based on movement
			if(this.velocity.y != 0)
			{
				this.play("jump");
			}
			else if(this.velocity.x == 0)
			{
				this.play("idle");
			}
			else
			{
				this.play("run");
			}
		}
	}
}

