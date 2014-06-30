package prison
{
	import com.adobe.images.JPGEncoder;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	internal class WallPost
	{
		public function WallPost()
		{
		}
		
		public function createSnapshot(stage:Stage):ByteArray
		{
			var jpgEncoder:JPGEncoder;
			jpgEncoder = new JPGEncoder(90);
			
			var bitmapData:BitmapData = new BitmapData(stage.width, stage.height);
			bitmapData.draw(stage, new Matrix());
			
			return jpgEncoder.encode(bitmapData);
		}
	}
}