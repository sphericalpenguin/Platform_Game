package
{
	import com.gauntlet.states.MenuState;
	import org.flixel.FlxGame;
	[Frame(factoryClass = "com.gauntlet.loading.Preloader")]
	
	/**
	 * ...
	 * @author Casey Sliger
	 */
	public class Main extends FlxGame 
	{
		/**
		 * 
		 */
		public function Main() 
		{
			super(1024, 768, MenuState, 1, 30, 30);
		}
		
	}
	
}