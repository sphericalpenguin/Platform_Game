package com.gauntlet.states
{
	import com.gauntlet.objects.Hero;
	import flash.display.BlendMode;
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		// Tileset that works with AUTO mode (best for thin walls)
		//[Embed(source = '../../../../embeded_resources/auto_tiles.png')]private static var auto_tiles:Class;
		[Embed(source = '../../../../embeded_resources/rockTile.png')]private static var auto_tiles:Class;
		
		// Default tilemaps. Embedding text files is a little weird.
		[Embed(source = '../../../../embeded_resources/default_auto.txt', mimeType = 'application/octet-stream')]private static var default_auto:Class;

		
		
		// Some static constants for the size of the tilemap tiles
		private const TILE_WIDTH:uint = 32;
		private const TILE_HEIGHT:uint = 32;
		
		// The FlxTilemap we're using
		private var collisionMap:FlxTilemap;
		
		// Player modified from "Mode" demo
		private var mcHero:Hero;
		
		
		private var quitBtn:FlxButton;
		private var helperTxt:FlxText;
		
		private var _nGenerationCount:int = 0;
		
		/**
		 * Set up the state.
		 */
		override public function create():void
		{
			// Creates a new tilemap with no arguments
			collisionMap = new FlxTilemap();
			
			this.generateRoomTiles();
			
			setupPlayer();
			
			quitBtn = new FlxButton(16, FlxG.height - 32, "Quit",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { FlxG.switchState(new MenuState()); } ); } );
			
			add(quitBtn);
			
			helperTxt = new FlxText(128, FlxG.height - 32, 150, "Health");
			helperTxt.size = 16;
			add(helperTxt);
		}
		
		/**
		 * Called every frame.
		 */
		override public function update():void
		{
			super.update();
			
			FlxG.collide(mcHero, collisionMap);
			
			wrap(mcHero);
			
		}
		
		/**
		 * 
		 */
		public override function draw():void
		{
			super.draw();
		}
		
		/**
		 * 
		 */
		private function setupPlayer():void
		{
			mcHero = new Hero(32, 640);
			
			add(mcHero);
		}
		
		/**
		 * 
		 */
		private function wrap(obj:FlxObject):void
		{
			if (obj.x > FlxG.width || obj.x < 0)
				this.generateRoomTiles();
				
			obj.x = (obj.x + obj.width / 2 + FlxG.width) % FlxG.width - obj.width / 2;
			obj.y = (obj.y + obj.height / 2) % FlxG.height - obj.height / 2;
		}
		
		/**
		 * 
		 */
		private function generateRoomTiles():void
		{
			collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			
			for (var x :int = 1; x < collisionMap.widthInTiles - 1; x++)
			{
				for (var y :int = 3; y < collisionMap.heightInTiles - 2; y+=2)
				{
					if(Math.random() * 20 > 5)
						collisionMap.setTile(x, y, 1);
				}
			}
			this._nGenerationCount++;
			add(collisionMap);
		}
	}
}
