package vk_prison.vk {

import vk.APIConnection;

public class Friends {
    internal var _VK:APIConnection;

    public function Friends() {
        _VK = Config.getInstance().VK;
    }

    public function getFriendsList(onSuccess:Function):void {
        _VK.api('friends.getAppUsers', {
        }, function(data:Object):void {
            if (data.length > 0) {
                getFriendsNames(data.toString(), onSuccess);
            } else {
                onSuccess(null);
            }
        }, function(data:Object):void {
            trace("Fail friends.getAppUsers with error_msg: " + data.error_msg + "\n");
        });
    }

    private function getFriendsNames(uids:String, onSuccess:Function):void {
        _VK.api('users.get', {uids : uids, fields : "uid, first_name, last_name, photo"},
        function(data:Object):void {
            onSuccess(data);
        }, function(data:Object):void {
            trace("Fail friends.getAppUsers with error_msg: " + data.error_msg + "\n");
        });
    }
}
}
