package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Nirvan
	 */
	public class Player extends Entity 
	{
		protected var xspeed:Number = 0;
		protected var yspeed:Number = 0;
		protected var blocked:int = 0;
		
		protected var maxSpeed:int = 10;
		protected var sprite:Spritemap = new Spritemap(DATA.PLAYER,96,96);
		
		public function Player(x:int,y:int) 
		{
			super(x, y-60, sprite);
			sprite.centerOO();
			sprite.add("run", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],30);
			sprite.play("run");
			setHitbox(30, 84, 15, 36);
		}
		
		override public function update():void 
		{//height / 2
			if ( collide('solid', x + T(xspeed * 40), y-2) ) { xspeed = 0; blocked = sprite.scaleX; } else blocked = 0;

			if ( collide('solid', x, y + T(yspeed * 40)) ) { moveTowards(x, y + T(yspeed * 40), T(yspeed * 40), 'solid', true);  yspeed = 0; } else yspeed += T(40);
			
			if (blocked == 0) x += T(xspeed * 40);
			y += T(yspeed * 40); 
			if (xspeed != 0) sprite.scaleX = FP.sign(xspeed);
			
			if (x > 350 && x < FP.width - 350) FP.camera.x = x - 350;
			
			if ( Input.pressed(Key.UP)) { y -= 2; yspeed = -15; }
			
			if ( Input.check(Key.RIGHT) && Input.check(Key.LEFT) ) xspeed -= GV.SmoothValue(xspeed,0,5/GV.gameSpeed);
			if ( Input.check(Key.RIGHT) || Input.check(Key.LEFT) )
			{
				if (blocked != 1) { if (Input.check(Key.RIGHT) && xspeed < maxSpeed) xspeed++; }// else xspeed = 0;
				if (blocked !=-1) { if (Input.check(Key.LEFT) && xspeed > -maxSpeed) xspeed--; }// else xspeed = 0;
			}
			else
			{
				xspeed -= GV.SmoothValue(xspeed,0,5/GV.gameSpeed);
				if ( Math.abs(xspeed) < .75 ) xspeed = 0;
			}
			
			sprite.rate = Math.abs(xspeed / maxSpeed * 1.75);

			function T(v:Number):Number { return v * FP.elapsed; }
			
			super.update();
		}
		
	}

}