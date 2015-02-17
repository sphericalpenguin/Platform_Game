package com.gauntlet.states
{
	import com.gauntlet.states.PlayState;
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		/**
		 * Set up the state.
		 */
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-20,FlxG.width,"Dungeon Gauntlet");
			t.size = 32;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-100,FlxG.height-30,200,"click to start");
			t.size = 16;
			t.alignment = "center";
			add(t);
			
			FlxG.mouse.show();
		}

		/**
		 * Called every frame.
		 * 
		 */
		override public function update():void
		{
			super.update();

			if(FlxG.mouse.justPressed())
				FlxG.switchState(new com.gauntlet.states.PlayState());
		}
	}
}
