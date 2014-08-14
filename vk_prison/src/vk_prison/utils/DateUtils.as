package vk_prison.utils {
public class DateUtils {
    public static function getUnit(ages:uint):String {
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

    private static function LastTwoDigits(ages:uint):uint {
        return ages % 100;
    }

    private static function LastDigit(ages:uint):uint {
        return ages % 10;
    }

    public static function getRandomNumber(low:uint, high:uint):uint {
        return Math.floor(Math.random()*(1+high-low))+low;
    }

}
}