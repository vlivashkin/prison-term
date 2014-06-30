package prison
{
	internal class Helper
	{
		public function Helper()
		{
		}
		
		private function LastTwoDigits(ages:uint):uint
		{
			return ages % 100;
		}
		
		private function LastDigit(ages:uint):uint {
			return ages % 10;
		}
		
		public function getUnit(ages:uint):String
		{
			var last_two:uint = LastTwoDigits(ages);
			if ((last_two >= 11) && (last_two <= 14)) {
				return "лет";
			} else {
				var last:uint = LastDigit(ages);
				if (last == 1) {
					return "год";
				} else if ((last >= 2) && (last <= 4)) {
					return "года";
				} else
					return "лет";
			}
		}
	}
}