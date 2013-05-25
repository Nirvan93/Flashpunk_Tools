package net.flashpunk.graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import net.flashpunk.*;

	/**
	 * Performance-optimized non-animated image. Can be drawn to the screen with transformations.
	 */
	public class ParticleImage extends Graphic
	{
		/**
		 * Rotation of the image, in degrees.
		 */
		public var angle:Number = 0;
		
		/**
		 * Any bool.
		 */
		public var any:Boolean = true;		
		
		/**
		 * Scale of the image, affects both x and y scale.
		 */
		public var scale:Number = 1;
		
		/**
		 * X scale of the image.
		 */
		public var scaleX:Number = 1;
		
		/**
		 * Y scale of the image.
		 */
		public var scaleY:Number = 1;
		
		/**
		 * X origin of the image, determines transformation point.
		 */
		public var originX:Number = 0;
		
		/**
		 * Y origin of the image, determines transformation point.
		 */
		public var originY:Number = 0;
		
		/**
		 * Constructor.
		 * @param	source		Source image.
		 * @param	clipRect	Optional rectangle defining area of the source image to draw.
		 */
		public function ParticleImage(source:*, clipRect:Rectangle = null) 
		{
			if (source is Class)
			{
				_source = FP.getBitmap(source);
				_class = String(source);
			}
			else if (source is BitmapData) _source = source;
			if (!_source) throw new Error("Invalid source image.");
			_sourceRect = _source.rect;
			if (clipRect)
			{
				if (!clipRect.width) clipRect.width = _sourceRect.width;
				if (!clipRect.height) clipRect.height = _sourceRect.height;
				_sourceRect = clipRect;
			}
			createBuffer();
			updateBuffer();
		}
		
		/** @private Creates the buffer. */
		protected function createBuffer():void
		{
			if (_buffer) {
				_buffer.dispose();
				_buffer = null;
			}
			_buffer = new BitmapData(_sourceRect.width, _sourceRect.height, true, 0);
			_bufferRect = _buffer.rect;
			_bitmap.bitmapData = _buffer;
		}
		
		/** @private Renders the image. */
		override public function render(target:BitmapData, point:Point, camera:Point):void
		{
			// quit if no graphic is assigned
			if (!_buffer) return;
			
			// determine drawing location
			_point.x = point.x + x - originX - camera.x * scrollX;
			_point.y = point.y + y - originY - camera.y * scrollY;
			
			// render without transformation
			if (angle == 0 && scaleX * scale == 1 && scaleY * scale == 1)
			{
				target.copyPixels(_buffer, _bufferRect, _point, null, null, true);
				return;
			}
			
			// render with transformation
			_matrix.b = _matrix.c = 0;
			_matrix.a = scaleX * scale;
			_matrix.d = scaleY * scale;
			_matrix.tx = -originX * _matrix.a;
			_matrix.ty = -originY * _matrix.d;
			if (angle != 0) _matrix.rotate(angle * FP.RAD);
			_matrix.tx += originX + _point.x;
			_matrix.ty += originY + _point.y;
			target.draw(_bitmap, _matrix, null);
		}

		/**
		 * Updates the image buffer.
		 */
		public function updateBuffer(clearBefore:Boolean = false):void
		{
			if (!_source) return;
			if (clearBefore) _buffer.fillRect(_bufferRect, 0);
			_buffer.copyPixels(_source, _sourceRect, FP.zero, _drawMask, FP.zero);
			if (_tint) _buffer.colorTransform(_bufferRect, _tint);
		}
		
		/**
		 * Clears the image buffer.
		 */
		public function clear():void
		{
			_buffer.fillRect(_bufferRect, 0);
		}
		
		/**
		 * Change the opacity of the Image, a value from 0 to 1.
		 */
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void
		{
			value = value < 0 ? 0 : (value > 1 ? 1 : value);
			if (_alpha == value) return;
			_alpha = value;
			updateColorTransform();
		}
		
		/**
		 * Updates the color transform
		 */
		protected function updateColorTransform():void {
			if (_alpha == 1) {
				if (_tintFactor == 0) {
					_tint = null;
					return updateBuffer();
				}
				if (_color == 0xFFFFFF) {
					_tint = null;
					return updateBuffer();
				}
			}
			_tint = _colorTransform;
			
			_tint.redMultiplier   = _tintMode * (1.0 - _tintFactor) + (1-_tintMode) * (_tintFactor * (Number(_color >> 16 & 0xFF) / 255 - 1) + 1);
			_tint.greenMultiplier = _tintMode * (1.0 - _tintFactor) + (1-_tintMode) * (_tintFactor * (Number(_color >> 8 & 0xFF) / 255 - 1) + 1);
			_tint.blueMultiplier  = _tintMode * (1.0 - _tintFactor) + (1-_tintMode) * (_tintFactor * (Number(_color & 0xFF) / 255 - 1) + 1);
			_tint.redOffset       = (_color >> 16 & 0xFF) * _tintFactor * _tintMode;
			_tint.greenOffset     = (_color >> 8 & 0xFF) * _tintFactor * _tintMode;
			_tint.blueOffset      = (_color & 0xFF) * _tintFactor * _tintMode;
			
			_tint.alphaMultiplier = _alpha;
			updateBuffer();
		}
		
		/**
		 * Centers the Image's originX/Y to its center.
		 */
		public function centerOrigin():void
		{
			originX = _bufferRect.width / 2;
			originY = _bufferRect.height / 2;
		}
		
		/**
		 * Centers the Image's originX/Y to its center.
		 */
		public function centerOO():void
		{
			centerOrigin();
		}
		
		/**
		 * Width of the image.
		 */
		public function get width():uint { return _bufferRect.width; }
		
		/**
		 * Height of the image.
		 */
		public function get height():uint { return _bufferRect.height; }
		
		/**
		 * Clipping rectangle for the image.
		 */
		//public function get clipRect():Rectangle { return _sourceRect; }
		
		/** @protected Source BitmapData image. */
		protected function get source():BitmapData { return _source; }
		

		
		// Locking
		/** @private */ protected var _needsClear:Boolean = false;
		/** @private */ protected var _needsUpdate:Boolean = false;
		
		// Source and buffer information.
		/** @private */ protected var _source:BitmapData;
		/** @private */ protected var _sourceRect:Rectangle;
		/** @private */ protected var _buffer:BitmapData;
		/** @private */ protected var _bufferRect:Rectangle;
		/** @private */ protected var _bitmap:Bitmap = new Bitmap;
		
		// Color and alpha information.
		/** @protected */ protected var _alpha:Number = 1;
		/** @protected */ protected var _color:uint = 0x00FFFFFF;
		/** @protected */ protected var _tintFactor:Number = 1.0;
		/** @protected */ protected var _tint:ColorTransform;
		/** @protected */ protected var _colorTransform:ColorTransform = new ColorTransform;
		/** @protected */ protected var _matrix:Matrix = FP.matrix;
		/** @protected */ protected var _tintMode:Number = 0.0;
		/** @protected */ protected var _drawMask:BitmapData;
		
		// Flipped image information.
		/** @protected */ protected var _class:String;
		/** @protected */ protected var _flipped:Boolean;
		/** @protected */ protected var _flip:BitmapData;
		/** @protected */ protected static var _flips:Object = { };
	}
}
